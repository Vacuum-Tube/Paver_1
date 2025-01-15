local Polygon = require "paver.polygon"

MultiPolygon = {}
MultiPolygon.__index = MultiPolygon

function MultiPolygon:Create( points_outer, points_inner )
    local mp = {
		outer = {},
		inner = {},
	}
	assert(#points_outer>0)
	for i,points in pairs(points_outer) do
		mp.outer[i] = Polygon:Create(points)
	end
	for i,points in pairs(points_inner) do
		mp.inner[i] = Polygon:Create(points)
	end
    setmetatable(mp, MultiPolygon)
    return mp
end

function MultiPolygon:GetBounds()
    local xmin, xmax, ymin, ymax
	for i,polygon in pairs(self.outer) do
		local bounds = polygon:GetBounds()
        if (not xmin or bounds.x < xmin) then
            xmin = bounds.x
        end
        if (not xmax or (bounds.x+bounds.width) > xmax) then
            xmax = (bounds.x+bounds.width)
        end
        if (not ymin or bounds.y < ymin) then
            ymin = bounds.y
        end
        if (not ymax or (bounds.y+bounds.height) > ymax) then
            ymax = (bounds.y+bounds.height)
        end
	end
    return {
        x = xmin,
        y = ymin,
        width = xmax - xmin,
        height = ymax - ymin,
    }
end

function MultiPolygon:Contains(point, bounds)
	local contain_outer = false
	for i,polygon in pairs(self.outer) do  -- must be contained in at least 1 outer polygon
		if polygon:Contains(point, bounds) then
			contain_outer = true
			break
		end
	end
	if not contain_outer then
		return false
	end
	for i,polygon in pairs(self.inner) do  -- And must not be contained in any inner polygon
		if polygon:Contains(point, bounds) then
			return false
		end
	end
	return true
end

function MultiPolygon:Triangulate()
	local triangles = {}
	for i,polygon in pairs(self.outer) do
		for j,triangle in pairs(polygon:Triangulate()) do
			table.insert(triangles, triangle)
		end
	end
	return triangles
end

return MultiPolygon
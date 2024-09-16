#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <cmath>
#include <algorithm>

class Point {
public:
    double x, y;
    std::string name;

    Point(double x = 0.0, double y = 0.0, std::string name = "") : x(x), y(y), name(name) {}
};

class Circle {
public:
    Point center;
    double radius;
    std::string color;

    Circle(Point center, double radius, std::string color) : center(center), radius(radius), color(color) {}

    friend std::ostream& operator<<(std::ostream& os, const Circle& c) {
        os << "Circle: center(" << c.center.x << ", " << c.center.y << "), radius " << c.radius << ", color " << c.color;
        return os;
    }

    double distance_to_point(Point p) const {
        return std::sqrt(std::pow(p.x - center.x, 2) + std::pow(p.y - center.y, 2));
    }

    double operator-(Circle& other) {
         double distance = this->distance_to_point(other.center);

        // No overlap
        if (distance >= this->radius + other.radius) {
            return 0.0;
        }

        // One circle is completely inside the other
        if (distance <= std::abs(this->radius - other.radius)) {
            double smallerRadius = std::min(this->radius, other.radius);
            return M_PI * smallerRadius * smallerRadius;
        }

        // Partial overlap
        double r1 = this->radius, r2 = other.radius;
        double part1 = r1 * r1 * std::acos((distance * distance + r1 * r1 - r2 * r2) / (2 * distance * r1));
        double part2 = r2 * r2 * std::acos((distance * distance + r2 * r2 - r1 * r1) / (2 * distance * r2));
        double part3 = 0.5 * std::sqrt((-distance + r1 + r2) * (distance + r1 - r2) * (distance - r1 + r2) * (distance + r1 + r2));

        return part1 + part2 - part3;
    }
};

void write_circles_to_file(const std::vector<Circle>& circles, double intersectionArea, const std::string& file_name) {
    std::ofstream file(file_name, std::ios::app); // Open in append mode
    if (!file) {
        std::cerr << "Error opening file for writing." << std::endl;
        return;
    }

    for (const auto& circle : circles) {
        file << circle << std::endl;
    }

    // Write intersection area to the file
    file << "Intersection area of c1 and c2: " << intersectionArea << std::endl;

    file.close();
}


int main() {
    std::vector<Circle> circles = {
        Circle(Point(0, 0), 5, "red"),
        Circle(Point(3, 4), 3, "blue")
    };

    // Sorting the circles by distance from the origin
    std::sort(circles.begin(), circles.end(), [](const Circle& a, const Circle& b) {
        return a.distance_to_point(Point()) < b.distance_to_point(Point());
    });

    // Displaying the circles
    for (const auto& circle : circles) {
        std::cout << circle << std::endl;
    }

    double intersectionArea = circles[0] - circles[1];
    std::cout << "Intersection area of c1 and c2: " << intersectionArea << std::endl;

    // Write circle details and intersection area to "circles.txt"
    write_circles_to_file(circles, intersectionArea, "circles.txt");

    return 0;
}


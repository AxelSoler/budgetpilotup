module ApplicationHelper
  def nav_link_to(name, path)
    base_classes = "px-3 py-1.5 rounded-lg font-semibold transition"
    active_classes = "bg-blue-600 text-white"
    inactive_classes = "text-blue-600 hover:text-blue-800"

    active = request.path.start_with?(path)

    classes = "#{base_classes} #{active ? active_classes : inactive_classes}"

    link_to name, path, class: classes
  end
end

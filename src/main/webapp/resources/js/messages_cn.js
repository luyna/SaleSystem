/**
 * by  yujin  add
 */

jQuery.extend(jQuery.validator.messages, {
    required: "��ѡ�ֶ�",
	remote: "���������ֶ�",
	email: "��������ȷ��ʽ�ĵ����ʼ�",
	url: "������Ϸ�����ַ",
	date: "������Ϸ�������",
	dateISO: "������Ϸ������� (ISO).",
	number: "������Ϸ�������",
	digits: "ֻ����������",
	creditcard: "������Ϸ������ÿ���",
	equalTo: "���ٴ�������ͬ��ֵ",
	accept: "������ӵ�кϷ���׺�����ַ���",
	maxlength: jQuery.validator.format("������һ�� ��������� {0} ���ַ���"),
	minlength: jQuery.validator.format("������һ�� ���������� {0} ���ַ���"),
	rangelength: jQuery.validator.format("������ һ�����Ƚ��� {0} �� {1} ֮����ַ���"),
	range: jQuery.validator.format("������һ������ {0} �� {1} ֮���ֵ"),
	max: jQuery.validator.format("������һ�����Ϊ{0} ��ֵ"),
	min: jQuery.validator.format("������һ����СΪ{0} ��ֵ")
});
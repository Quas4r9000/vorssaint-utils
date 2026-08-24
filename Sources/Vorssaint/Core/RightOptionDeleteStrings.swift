// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

struct RightOptionDeleteStrings {
    let pageTitle: String
    let hubDescription: String
    let enableToggle: String
    let enableCaption: String
    let activeNow: String
}

extension FeatureStrings {
    static func rightOptionDelete(_ language: AppLanguage) -> RightOptionDeleteStrings {
        switch language {
        case .enUS: return .enUS
        case .ptBR: return .ptBR
        case .tr: return .tr
        case .ru: return .ru
        case .es: return .es
        case .de: return .de
        case .fr: return .fr
        case .it: return .it
        case .ja: return .ja
        case .ko: return .ko
        case .zhHans: return .zhHans
        case .zhTW: return .zhTW
        case .zhHK: return .zhHK
        }
    }
}

extension RightOptionDeleteStrings {
    static let enUS = RightOptionDeleteStrings(
        pageTitle: "Right Option as Forward Delete",
        hubDescription: "Turns the right Option key into Forward Delete.",
        enableToggle: "Use right Option as Forward Delete",
        enableCaption: "Pressing the right Option key deletes the character after the cursor. The left Option key keeps working as a modifier.",
        activeNow: "Working now"
    )

    static let ptBR = RightOptionDeleteStrings(
        pageTitle: "Option direita como apagar à frente",
        hubDescription: "Transforma a tecla Option direita em apagar à frente.",
        enableToggle: "Usar Option direita como apagar à frente",
        enableCaption: "Apertar a Option direita apaga o caractere depois do cursor. A Option esquerda continua funcionando como modificadora.",
        activeNow: "Funcionando agora"
    )

    static let tr = RightOptionDeleteStrings(
        pageTitle: "Sağ Option ileri silme",
        hubDescription: "Sağ Option tuşunu ileri silme tuşuna dönüştürür.",
        enableToggle: "Sağ Option'ı ileri silme olarak kullan",
        enableCaption: "Sağ Option tuşuna basmak imleçten sonraki karakteri siler. Sol Option değiştirici olarak çalışmaya devam eder.",
        activeNow: "Şu anda çalışıyor"
    )

    static let ru = RightOptionDeleteStrings(
        pageTitle: "Правая Option как удаление вперёд",
        hubDescription: "Превращает правую клавишу Option в удаление вперёд.",
        enableToggle: "Использовать правую Option как удаление вперёд",
        enableCaption: "Нажатие правой Option удаляет символ после курсора. Левая Option продолжает работать как модификатор.",
        activeNow: "Работает"
    )

    static let es = RightOptionDeleteStrings(
        pageTitle: "Option derecha como borrar hacia delante",
        hubDescription: "Convierte la tecla Option derecha en borrar hacia delante.",
        enableToggle: "Usar Option derecha como borrar hacia delante",
        enableCaption: "Pulsar la Option derecha borra el carácter que sigue al cursor. La Option izquierda sigue funcionando como modificadora.",
        activeNow: "Funcionando ahora"
    )

    static let de = RightOptionDeleteStrings(
        pageTitle: "Rechte Option als Vorwärtslöschen",
        hubDescription: "Macht aus der rechten Option-Taste die Vorwärtslöschen-Taste.",
        enableToggle: "Rechte Option als Vorwärtslöschen verwenden",
        enableCaption: "Ein Druck auf die rechte Option löscht das Zeichen nach dem Cursor. Die linke Option funktioniert weiter als Sondertaste.",
        activeNow: "Läuft gerade"
    )

    static let fr = RightOptionDeleteStrings(
        pageTitle: "Option droite en suppression avant",
        hubDescription: "Transforme la touche Option droite en suppression avant.",
        enableToggle: "Utiliser Option droite comme suppression avant",
        enableCaption: "Appuyer sur Option droite supprime le caractère après le curseur. La touche Option gauche continue de servir de modificateur.",
        activeNow: "Actif maintenant"
    )

    static let it = RightOptionDeleteStrings(
        pageTitle: "Option destra come elimina avanti",
        hubDescription: "Trasforma il tasto Option destro in elimina avanti.",
        enableToggle: "Usa Option destra come elimina avanti",
        enableCaption: "Premendo Option destra si elimina il carattere dopo il cursore. Option sinistra continua a funzionare come modificatore.",
        activeNow: "Attivo ora"
    )

    static let ja = RightOptionDeleteStrings(
        pageTitle: "右Optionを前方削除に",
        hubDescription: "右のOptionキーを前方削除キーに変えます。",
        enableToggle: "右Optionを前方削除として使う",
        enableCaption: "右Optionを押すとカーソルの後ろの文字を削除します。左Optionは修飾キーとしてそのまま使えます。",
        activeNow: "動作中"
    )

    static let ko = RightOptionDeleteStrings(
        pageTitle: "오른쪽 Option을 앞으로 삭제로",
        hubDescription: "오른쪽 Option 키를 앞으로 삭제 키로 바꿉니다.",
        enableToggle: "오른쪽 Option을 앞으로 삭제로 사용",
        enableCaption: "오른쪽 Option을 누르면 커서 뒤의 문자를 삭제합니다. 왼쪽 Option은 계속 수정자 키로 동작합니다.",
        activeNow: "지금 작동 중"
    )

    static let zhHans = RightOptionDeleteStrings(
        pageTitle: "右 Option 用作向前删除",
        hubDescription: "把右 Option 键变成向前删除键。",
        enableToggle: "将右 Option 用作向前删除",
        enableCaption: "按右 Option 键会删除光标后的字符。左 Option 键仍作为修饰键使用。",
        activeNow: "正在运行"
    )

    static let zhTW = RightOptionDeleteStrings(
        pageTitle: "右 Option 用作向前刪除",
        hubDescription: "把右 Option 鍵變成向前刪除鍵。",
        enableToggle: "將右 Option 用作向前刪除",
        enableCaption: "按右 Option 鍵會刪除游標後的字元。左 Option 鍵仍作為修飾鍵使用。",
        activeNow: "正在運作"
    )

    static let zhHK = RightOptionDeleteStrings(
        pageTitle: "右 Option 用作向前刪除",
        hubDescription: "將右 Option 鍵變成向前刪除鍵。",
        enableToggle: "將右 Option 用作向前刪除",
        enableCaption: "撳右 Option 鍵會刪除游標後嘅字元。左 Option 鍵仍然作為修飾鍵使用。",
        activeNow: "正在運作"
    )
}

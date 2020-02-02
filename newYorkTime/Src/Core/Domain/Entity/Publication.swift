//
//  Publication.swift
//  newYorkTime
//
//  Created by javi on 01/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

struct Publication {
    
    let url:String?
    let title:String
    let author:String
    let section:String
    let publishedDate:String
    let imageURL:String?
    
    init(withRawData rawData: ResultDataRaw) {
        self.url = rawData.url
        self.title = rawData.title ?? ""
        self.author = rawData.author ?? ""
        self.section = rawData.section ?? ""
        self.publishedDate = rawData.publishedDate ?? ""
        if let mediaUnwrapped:MediaDataRaw = rawData.media?.first(where: { (mediaDataRow) -> Bool in
            return mediaDataRow.type == "image" //TODO convertir en enum en el modelo para poder comparar bien
        }), let imageURLString:String =  mediaUnwrapped.mediaMetadata.first(where: { (mediaMetaDataRaw) -> Bool in
            guard let mediaDataHeight:Int = mediaMetaDataRaw?.height else {
                return false
            }
            return  mediaDataHeight <= 100 && mediaDataHeight > 60 //Devolvemos la primera imagen que concuerde entre lo que queremos dibujar. Podríamos haberlas categorizado previamente por el formato, por ejemplo habiendo incluido un enumerado de formatos en el modelo de datos, pero al no disponer de todos los tipos existentes esta solución sirve para representarlo.
        })??.url {
            self.imageURL = imageURLString
        } else {
            self.imageURL = nil
        }
    }
}

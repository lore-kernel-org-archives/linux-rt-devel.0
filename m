Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35021E5B7E
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Apr 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506551; cv=fail; b=ZGK/xKtKciQdbSEocljYs5C8srncXrC0mkusd8G969d7uB99581TyKFwWmBGIGeJO5JT+DzSXn9SBzfqvMYsPzDn8jf+jzTxy61Ol5JjLzmILq5NHJ9BvEZ2FxWISxoJVI/MF/47tdG5lN+GYPYt4YqBqLahL6/aiq97AjmyCZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506551; c=relaxed/simple;
	bh=YbtsYPJIdk3Lu6w2pEaQOYCMaMrMOAOYTffe3UmGkQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiAwLmuWzb23BTYc745BGxuuSggvvorHn1h+PQveO/sv8mCdmMQJaztxIA+R08Tw9q73O1P/yh8rLcrI/RqwZrvRITBhqKsPWbQSd6zK3x/h+SDfa88hQWigiEtQ2RPSMu8LOyzmje8IGUKo9enuw2gYBdZ09/UFpJ6DCKvPXGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=qEpD4clO; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="qEpD4clO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugZQmFQnkAcaNt3pEPI1a7fN9NnfTrdLV06GxUG8IildO4M5aYjKp+0+hmlXu+axRV4xASosA63RQVUpDq+Rp2a/9Gh5RSYH9UabYxBcAQlQSCsmf48VIWR6eTEYbDAotNA/lh0Th69YlmBUnIYItoimjAdPIP3EVFHaNB043+b6olCa1m0H3UTEAS1LshID/u94J+27aBhRpChCTm/0ACOR1FPQIiAre1+b7ieJq4OoBesVJz63BoXA8M2f6txivfzO8sfH5V6SkM33ND0/5xZ098tXGjkrFb+8kqoHxwRJFs1kvP334HQ8pUQc2e1UxrzhX168Awyan+6Dh7lypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbtsYPJIdk3Lu6w2pEaQOYCMaMrMOAOYTffe3UmGkQE=;
 b=TTi6QYVLOOVRs0czzTKz2q8/nhi+ILSXWy2n7ZJJa9NRJNa13tKG9o6sTgrgvPD5oXrQwjr9sXGt7JJbZlKWSGKSBCWaERUBVJn/NiaJmevWffRxv2iR5akad7pc/MpRPmVJ0ipQ49+osoCuJGJi2wb21GG1//IMjABFRkQFz3B2jQ3MgUj56CEH4YRPf0IuhKbX5A6fkAUx3s1ZUcQiGpxBAVZomMCfph4PzxzvkzdSQBIhHw2paRPlfZkQ21G9HLBG5gZr++Ue0l2/dKAXsiReuGYbvQeda0m6Gs0Fv5AhlypGtNPLylXRXK2zpHh2smOwJ/Wi4JvvUq5+W7oT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbtsYPJIdk3Lu6w2pEaQOYCMaMrMOAOYTffe3UmGkQE=;
 b=qEpD4clOYN44ZEEAWk2YBzLy22G3WRKstfugwA08U7zdxb8NYdzeLt1mjqtfECTzeQleah7CpNqn+QZf3aJyp7tsl/f9Ib6NpQ3s3eIsNX2YIU1IKfjUd1gMYVPamJG0Mbbj8/0NEHH124w/EFtfUmdKZckuaut5ubAFxIpfntBKgMK3Mneyk2OH7oqVl0uwcFbgBUOj9Ghb8PY9H6p5TQWRitkIb0UVAXX9yTWMZORDHVyTo2nJ4VRBmbqdG2CuM7dvvzLFX8FoTMtxIR7fZkvPqaMBq7ZKlXKOX+1+n/avp2xe6PRQa7EnAWgHIIZxyegjnBt7GthvbkNAHszn3w==
Received: from AS8PR07MB8117.eurprd07.prod.outlook.com (2603:10a6:20b:370::8)
 by DU2PR07MB8253.eurprd07.prod.outlook.com (2603:10a6:10:276::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Tue, 1 Apr
 2025 11:22:24 +0000
Received: from AS8PR07MB8117.eurprd07.prod.outlook.com
 ([fe80::9829:72d7:16f1:dc8c]) by AS8PR07MB8117.eurprd07.prod.outlook.com
 ([fe80::9829:72d7:16f1:dc8c%4]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 11:22:24 +0000
From: "Ismo 1. Puustinen (Nokia)" <ismo.1.puustinen@nokia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: RE: Two kernel oopses
Thread-Topic: Two kernel oopses
Thread-Index: Adue8/Iya5phMHMuSUK9E+foAOfLhADEpzKAADs0jvA=
Date: Tue, 1 Apr 2025 11:22:24 +0000
Message-ID:
 <AS8PR07MB8117432C9C7C051F57D7495485AC2@AS8PR07MB8117.eurprd07.prod.outlook.com>
References:
 <AS8PR07MB8117D39772278625220157B085A12@AS8PR07MB8117.eurprd07.prod.outlook.com>
 <20250331063139.WHL_PGTC@linutronix.de>
In-Reply-To: <20250331063139.WHL_PGTC@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB8117:EE_|DU2PR07MB8253:EE_
x-ms-office365-filtering-correlation-id: 3942935e-b18d-4972-bdaa-08dd710f7a40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q21vOWdSVHB2dzBYMGxOSXVvUjZHTnNHQjIwNFpXVnhhS3R0em96Ym1VMlk2?=
 =?utf-8?B?T2RSZ01GaVdMY0hwM045TXhvU3h2dWNXZ3pEL2hsY2dCOVNubFJ2S0JETlc2?=
 =?utf-8?B?K1JXbDQvVk11OWx0Qm1wRnZuMFBpNzBsV3lEM01FT3gyZEdab3pETDhjenhF?=
 =?utf-8?B?SzZMeTJqTE1zTDFOdk16dWxRcVVybC95bHRTMU5RL3lDTmVMQVBXODlyWDd2?=
 =?utf-8?B?cjhhREtaVHN4VEdDb1RFblVLYVZ5VWtLSFVJbmZhUncrY1BCQk4yZEZwOGtu?=
 =?utf-8?B?Y25nU0tFM0NqVGk4ZDYvUUpjSlZpZjB3TkFTOEFWMit0eWtTTXcwcFdvWC9a?=
 =?utf-8?B?Nk1rVWFTOTc3RU8vNVRMLzhzdEpSWU05T0hnMmN1Zkc0bC8yczNXSzFvZTZG?=
 =?utf-8?B?RUordFF0eEkvQW4yT0FaVWN4UXBoVmZEd2JRcWpwNFRVbG02aEtuWTFSSzZ6?=
 =?utf-8?B?dEd3QzNlZElMTTFVdlpmUU1RRjRoRGhvNTZNcDlicDFJcUxMeTJKeHRjUlNK?=
 =?utf-8?B?WFB1ODFHT2p5NGQ0bXhYa3oxNDY5WTNQQWZCOTZCMktlVldaeTVNVko4OG92?=
 =?utf-8?B?bmZodFBZdW9LckxWWUpncURBWlR0ZVpCZTFZZFZlU2lNUUd1QWZtWE4zM0Jn?=
 =?utf-8?B?YXZxcTFhYitHUSs1L2pMQ05Ua3dQSENod2FzY0RCd0l1S0ludWV1a1l0Z0Zz?=
 =?utf-8?B?eGRMcWhzd3NSbE9TQlRIL3A0STBjeXYrdWtPK3A1YUt3WUdkalBZN0NNUWp1?=
 =?utf-8?B?WlMrRTcramhhU1MzWmx3LzhPTW5ON0FWd09lRStJVmNpL1hkMmt2eGNFN0dz?=
 =?utf-8?B?K1BUbEsyUFdnNWhSaFlZOGhFWFN3MlRBTWUxYmZub0NkRXBWeVU2NHhxZ2Vj?=
 =?utf-8?B?TDdtNm5iSFlDUWEwUG5zcWVkRFdWay9ySXpOVmhuejgwQWdlSjBoRHE4dkxp?=
 =?utf-8?B?dittMW53SGxPSVYzVEF6SEwxMFUycExMcWlCRW9XYVJOeVA1ejYrK1VyelBl?=
 =?utf-8?B?NFdxem9ZdUpVcHRWdjRMSjBkd3UxemVNOHZlU0Mvd2l3VGdsWlVRd1dyb0lH?=
 =?utf-8?B?aGdWZTd1NDZGZ2M2aTl2cjdpU0M1RkR5ZVdTRHlrcjJtOUtkZjAzQmNSWHRI?=
 =?utf-8?B?aXB1bG5hSDlMM0hZWmNxZGhOd1d3ZzNSZG5rR0syU0M1QmpySU5MWkNRTFh6?=
 =?utf-8?B?bklLWEdsSzdnUDFxZTc3d211a3M5VFZZWmkxQ3BDQWVDdHl1SE03ZmV4ZTdH?=
 =?utf-8?B?eVgrVTBSQzFtRVhxamVJbWppWFpySmw1cnV4SkpMZUFEWHh1dDQvM2lUbUtm?=
 =?utf-8?B?ek5NM3U3NjZHWEk2MVRqVmx0TTBaM0dVMUJxbklEY3JmcHR0RVlWek5aQ3V0?=
 =?utf-8?B?Yk4xWlhBTVhHTzFQZ3NSK1ArYkhEcmNsYThPNTF6aWtwcW5BeXFYMDY4VFpn?=
 =?utf-8?B?WGZLVER0NHBJbEJsUEpnUjFsRHhkOXZQNm5tUW5qa0NTMzdyRTRlR2lZeVdm?=
 =?utf-8?B?R3JHOFpWNHY4czdtZFRJTlVhZlA3UjQ3ZWlKYmwvQk5NbEF3S2tFOFh4dlhR?=
 =?utf-8?B?anFQVmVlbEZuS0loWGhINEFQZS9wd2V1THlMMGoxall6RE4rU2tVVkk5WGMv?=
 =?utf-8?B?Sm1PZEIvaGVPV2ZkWkxNNkhXN2swaUdZTlIxRDBWdDRBeUt0bUx2bjBleFVS?=
 =?utf-8?B?OXo5NTNzcU8raTllWVRxclIyNUNDV0tPNDh2TisyY2ZydHlLZjR5Z0NJK2Vt?=
 =?utf-8?B?RnpmNGJPN2Q3eW01L2phV0FFVHlCUHNpVVk2VnFqUzIzWEpNNStIcU9RN1hW?=
 =?utf-8?B?N2VkVGl3bEM4S3ArMVJwOUpjV3k2bEx5bFlGbnNycEN0eEVMNmNvSzVNWXVV?=
 =?utf-8?B?clQ4SGovTnF5VGxrVVdaWnRtSHRjQ1dMWTYvQjkzb1F1eEYyTTYyZzFFZWlz?=
 =?utf-8?B?dGJ6VnNFZWNEd3ROKzF6bjkvalNFQXF5TG9XNzB4bnVnQmxSTzE5ZzhoWUFS?=
 =?utf-8?B?V1JacHNBazdRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB8117.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3dVSUplWUV4azFhcmwvUW45SlhINm8zV0h0dk9ONWQzWmFOZnJjQUdIMWQy?=
 =?utf-8?B?RjJWZ2IvNnc4WjFaWW9Xakc3Q1RnLzhnK0dhM0kzQXFMUE5oS3J0dEx6bnNa?=
 =?utf-8?B?dVJlMkZ5WUljL2pNQjU0ZE91ZG44RDE1c3J4RlExNFRxcHBEanJ2UUFhZnkw?=
 =?utf-8?B?WklyT3lkQ1pmTTZoRFdPbWlOT0J2NU41SHJ0RnF0UWI1dExCWmt1aDBKUHp2?=
 =?utf-8?B?aWJyOUNCbExZdzVuenhpREljRGFxcGUyYUFiSlNXU2lEdng3WHdzTzhrU0sr?=
 =?utf-8?B?YnJRZFlNYmFBZ293V05QZVE4TE9CS0lKMENpM25vdGxUWTZsL1JMVzFYZzBX?=
 =?utf-8?B?VmVBTmR4WU8xUk9zMGJOaFJmanByeHUyQkFrT0tnVUxKVGxDLzJPOFQvYlZO?=
 =?utf-8?B?S01aa1hOaVdkOE9jSzY1V0QwNTBtYXRJaS9WQWM3cExoOTZORms1bXI5RTNR?=
 =?utf-8?B?ZG43cHpmMXRxeTd3ZEwvTGJnVWpZVXBwcVNvREhpTThYRnI4a1YvZERwWEdS?=
 =?utf-8?B?RWQ2N1RsMzNiN0YrYWhMZUFmcE1ZNk5ZRWpNM2hnTW1IT1NLMERIRU1rMDlq?=
 =?utf-8?B?V1lnQm1ITWdVaEo2NmVRbW55M2RWaTNtMjd2bU1SMnVpSTBwMFlOeGNVMHFn?=
 =?utf-8?B?ZytWL0Z6TzNhSDJqTzg3K0Z0WlFpdjBTbTh5MzZ4c09PcTgycGN3MS9BZGxv?=
 =?utf-8?B?eUFoWk1nVWZEcEJZUHRpSmhnUVpUTEt1UmJNdm1kVFk1OGZENnVQTlhxck5V?=
 =?utf-8?B?ZTQvK25DSFcrcEdZbGpibUEwcW81WjlPUUlJTHcrYnFad1A0TmFTKzkrM2xo?=
 =?utf-8?B?THFsbXg0NVlVRzJaQ0lLQUErL3BFNE5UUjRaTzNPamVuMW4xQ2lzL0t5Q0J6?=
 =?utf-8?B?MEo3S252YzN5bWRJekJ4Q0xnNWRSb2RZb3piRmJnRkFOM1pzQzg2QWVHcUNV?=
 =?utf-8?B?MjJ0NGZpNmxrTXpsZFlvMkJEYS9VcHorM2tadlJEU2xoQklwWlJ4S2VORFBk?=
 =?utf-8?B?OWRMS2E0eVlpTGZyOW5jNG9BWDlYNTdlbDZST2F2ajZHd0JkOC9sU2ViZGNM?=
 =?utf-8?B?bkh3YWh1LzRMYklCU0R6MVAvR2taVXFYbldvZVdVNm4wZkcydXgxY2M0Snl5?=
 =?utf-8?B?OEU3ZktlOWp3NTRTaWxZMlh0bXhLdTBVNEM1NFQ4S2w1Wm9Hb0JsRmJ2MDR4?=
 =?utf-8?B?WVFDb2d0bml1R3h0NUJFYWpxeHlGT3Nrc3p1dndLamMvbFVkNW1IN1dkeGRU?=
 =?utf-8?B?UVNlRjdhaWRjdnhWQkN5ZUdsSWVGdWhCazZEZWNDUDRPYWJna2xwZFJlWk5O?=
 =?utf-8?B?clB4RVljN3laR1U5OXFIK04zN3ZkdEpXczFaMmtKQm8vcWNFZFZDblg1dmYv?=
 =?utf-8?B?UHhvUTFLVWpRWnovaGRTblNmVDhWaG1WdW9yRDNHbE1MVy9qdjB3QUNHd2th?=
 =?utf-8?B?QUYrTFNHdUZ3eVd2UWFHVlJlZ0hhaXhLZngwMTFaTXg4T1ZFd0xmM3NjZHNV?=
 =?utf-8?B?c2xZZGNIdk54ejVFU0JjRDE4cCswdUFqTXpJaDROeTJDdEp3TnkweFU5MXht?=
 =?utf-8?B?eERjS0JGK1cvYTAxMjlmOUhoQ3pPMWpLRkNYYWk5QjdIaEg0TjJPU0hWeUFi?=
 =?utf-8?B?bDNaR0Nvd2thcW5vZldwSld1T1FpcW5jaEtMRUV0RktJcEZnOUVobERIcTJF?=
 =?utf-8?B?N1dySFpmWWVpS01HNktiN0tHL0pnckprSmV4ZVh0SHVseDJydUVsK0t2ejRP?=
 =?utf-8?B?aGxRaklMNVg3emxuUXNPWVRGRWsrVFhpVzFWR2lSUmVuUyswQ2tDOW4xSE1r?=
 =?utf-8?B?MlYyaFk4L3dnaUd0V1lob0ZnSU5MRDJJd2JDNzhndEo3RkVNdGtEQTRaWjBh?=
 =?utf-8?B?Rnp3OVY3VWxpU1g1NFVHR0Z1bmptSWxsM2RmZ1UxZTM4WWNnVmNjdlZwalNa?=
 =?utf-8?B?THR0enZ0aW9WNVZGSHJrclJTYWNWcmp5RkFCSUhCdWtsYzIzNFRaMlZDb0RO?=
 =?utf-8?B?TlVha3N3Q2p6TFJ0WGV6OU1oY3QxOC8rdmtIT0xTb3ZBNC94bkJrUEZpRFFJ?=
 =?utf-8?B?dEphaldVdFFJR3B5YUVzOUN3Nlo1bGl0Qmoxd1NmUm8wRUhWZmxuSUFEMHFI?=
 =?utf-8?B?T1NmNG1WblNtTnZCazVmYjhFUzlHM2k0Uy9PRmtZVDl3bHUxcVNQR3A4anNz?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB8117.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3942935e-b18d-4972-bdaa-08dd710f7a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 11:22:24.5470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lslfSmdvKQOLlN8XAKKcft3EshMxnJhVIU2Xaa/dKJIiFXOQvJTbR6jOkZ7MithZGXZ7gunKmXppRS7SelJpA0CyLzSGwAcjhinAAfS4S0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8253

T24gMjAyNS0wMy0zMSAwOTozMjoxMSBbKzAzMDBdLCBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9y
IHdyb3RlOg0KDQo+IEkgZG9uJ3Qga25vdyB3aGF0IFRhbG9zIExpbnV4IGlzLiBEbyB5b3UgaGF2
ZSBhIHZhbmlsbGEgdjYuMTIuMTMgb3IgZG8geW91DQo+IGhhdmUgYW55IHBhdGNoZXMgKGxpa2Ug
dGhlIFBSRUVNUFRfUlQgcGF0Y2ggZm9yIHY2LjEyKSBvbiB0b3A/DQoNClRhbG9zIExpbnV4IGlz
IGEgbWluaW1hbCBMaW51eCBkaXN0cmlidXRpb24gZm9yIHJ1bm5pbmcgYSBLdWJlcm5ldGVzIG5v
ZGUuIFRoZSBzeXN0ZW0gaGFzIHZhbmlsbGEgNi4xMi4xMy4gV2UgYnVpbGQgaXQgb3Vyc2VsdmVz
IGJlY2F1c2UgVGFsb3MgZG9lc24ndCBwcm92aWRlIGEgUlQga2VybmVsLiBJJ20gYWxzbyBub3Qg
c3VyZSB3aHkgdGhlIHNlcGFyYXRlIFBSRUVNUFRfUlQgcGF0Y2ggd291bGQgYmUgbmVlZGVkIG9u
IDYuMTIgLS0gc2hvdWxkIEkgdXNlIGl0Pw0KDQo+IEJvdGggdGhpbmdzIGFyZSBzY2hlZHVsZXIg
cmVsYXRlZCBhbmQgbWVzcyB1cCBpdHMgaW50ZXJuYWwgc3RhdGUvIHRyYWNraW5nLiBJDQo+IGhh
dmVuJ3Qgc2VlIGFueXRoaW5nIGxpa2UgaXQgc28gZmFyLiBJdCB3b3VsZCBiZSBnb29kIHRvIGtu
b3cgaWYgeW91IGhhdmUgYW55DQo+IGV4dGVybmFsIHBhdGNoZXMgb3IgaWYgeW91IGRvIGFueXRo
aW5nIGVsc2UgdXN1YWwgdG8gdHJhY2sgdGhpcyBkb3duLg0KDQpUaGVyZSBpc24ndCBhbnl0aGlu
ZyBzcGVjaWFsIHRoYXQgSSBjYW4gdGhpbmsgb2YuIFRoZSBjcmFzaGVzIHNlZW0gdG8gaGFwcGVu
IG9uIGEgIm1vc3RseSBpZGxlIiBzeXN0ZW0gZXZlbiB3aXRob3V0IGFueSBzcGVjaWFsIGtlcm5l
bCBwYXJhbWV0ZXJzIG9yIHJ1biB0aGUgcmVhbC10aW1lIHdvcmtsb2Fkcy4gVGhlcmUgYXJlIGxv
dHMgb2YgcHJvY2Vzc2VzIHJ1bm5pbmcgb24gdGhlIHN5c3RlbSB0aG91Z2gsIGJ1dCB0aGUgY3B1
IGxvYWQgaXMgc21hbGwuIFRoZSBzZXJ2ZXIgaXRzZWxmIGlzIGEgbGFyZ2Ugb25lIHdpdGggNjQg
Y29yZXMsIHNvIEkgZ3Vlc3MgYW55IHJhY2UgY29uZGl0aW9ucyBhcmUgZWFzeSB0byB0cmlnZ2Vy
IHRoZXJlLiBUaGUgQklPUyB2ZXJzaW9uIGlzIHJlY2VudCwgdXNpbmcgYW4gb2xkZXIgdmVyc2lv
biBkb2Vzbid0IHNlZW0gdG8gYWZmZWN0IHRoZSBpc3N1ZXMuIEFsc28sIGZvciB3aGF0IGl0J3Mg
d29ydGgsIHdlIHNlZSB0aGUgc2FtZSBjcmFzaGVzIGFsc28gb24gNi4xMi42IGtlcm5lbC4gVGhl
IHJ0LmM6MTAzNSBjcmFzaCBzZWVtcyB0byBoYXBwZW4gaW4gYm90aCBJUlEgYW5kIFRBU0sgY29u
dGV4dC4gVGhlIGNyYXNoZXMgaGFwcGVuIG9uIHNldmVyYWwgKGlkZW50aWNhbCkgc2VydmVycy4N
Cg0KSSdsbCBhZGQgaGVyZSB0aGUgZmlyc3QgbGluZXMgb2YgYSBjb3VwbGUgb2Ygb29wc2VzIEkg
aGF2ZSBpbiBzdG9yZSwgSSBjYW4gYXR0YWNoIHRoZSBmdWxsIGJhY2t0cmFjZXMgaWYgaXQgaGVs
cHMuIEkgY2FuIGFsc28gYWRkIGZ1bGwga2VybmVsIGNvbmZpZ3VyYXRpb24gb3Igb3RoZXIgZGF0
YSBwb2ludHMgaWYgeW91IHRoaW5rIHRoYXQgaXQgbWF5IGhlbHAsIGFuZCBpZiB5b3UgdGhpbmsg
dGhlcmUgaXMgc29tZXRoaW5nIEkgY2FuIHRyeSBvdXQgdG8gaGVscCBmaW5kIHRoZSBpc3N1ZSBJ
J20gaGFwcHkgdG8gZG8gc28uDQoNClsyNDIwOC43NjEzOTJdIGtlcm5lbCBCVUcgYXQga2VybmVs
L3NjaGVkL3J0LmM6MTAzNSENClsyNDIwOC43NjEzOTldIE9vcHM6IGludmFsaWQgb3Bjb2RlOiAw
MDAwIFsjMV0gUFJFRU1QVF9SVCBTTVAgUFRJDQpbMjQyMDguNzYxNDAyXSBDUFU6IDM3IFVJRDog
MCBQSUQ6IDE5IENvbW06IHJjdV9wcmVlbXB0IE5vdCB0YWludGVkIDYuMTIuNi10YWxvcyAjMQ0K
WzI0MjA4Ljc2MTQwNV0gSGFyZHdhcmUgbmFtZTogSFBFIFByb0xpYW50IERMMTEwIEdlbjExL1By
b0xpYW50IERMMTEwIEdlbjExLCBCSU9TIDIuNDQgMDEvMTcvMjAyNQ0KWzI0MjA4Ljc2MTQwNl0g
UklQOiAwMDEwOmRlcXVldWVfcnRfc3RhY2srMHgzNTkvMHgzYjANCg0KWzM3NzE4LjQ0ODczM10g
a2VybmVsIEJVRyBhdCBrZXJuZWwvc2NoZWQvcnQuYzoxMDM1IQ0KWzM3NzE4LjQ0ODc0N10gT29w
czogaW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBQUkVFTVBUX1JUIFNNUCBQVEkNClszNzcxOC40
NDg3NTZdIENQVTogMTEgVUlEOiAwIFBJRDogMCBDb21tOiBzd2FwcGVyLzExIE5vdCB0YWludGVk
IDYuMTIuNi10YWxvcyAjMQ0KWzM3NzE4LjQ0ODc2M10gSGFyZHdhcmUgbmFtZTogSFBFIFByb0xp
YW50IERMMTEwIEdlbjExL1Byb0xpYW50IERMMTEwIEdlbjExLCBCSU9TIDIuMTYgMDMvMDEvMjAy
NA0KWzM3NzE4LjQ0ODc2Nl0gUklQOiAwMDEwOmRlcXVldWVfcnRfc3RhY2srMHgzNTkvMHgzYjAN
Cg0KWzIwMDQ1LjEzNzg0MF0ga2VybmVsIEJVRyBhdCBrZXJuZWwvc2NoZWQvcnQuYzoxMDM1IQ0K
WzIwMDQ1LjEzNzg0OF0gT29wczogaW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBQUkVFTVBUX1JU
IFNNUCBQVEkNClsyMDA0NS4xMzc4NTFdIENQVTogNSBVSUQ6IDAgUElEOiA0MjMgQ29tbTogcmN1
b2cvNDggTm90IHRhaW50ZWQgNi4xMi42LXRhbG9zICMxDQpbMjAwNDUuMTM3ODUzXSBIYXJkd2Fy
ZSBuYW1lOiBIUEUgUHJvTGlhbnQgREwxMTAgR2VuMTEvUHJvTGlhbnQgREwxMTAgR2VuMTEsIEJJ
T1MgMi40OCAwMy8xMS8yMDI1DQpbMjAwNDUuMTM3ODU0XSBSSVA6IDAwMTA6ZGVxdWV1ZV9ydF9z
dGFjaysweDM1OS8weDNiMA0KDQpUaGFua3MhDQoNCklzbW8NCg==

Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118E171A1
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 May 2025 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430290; cv=fail; b=Yc4fTo7NkerIfNDl+vO2Wde8PT/6FjWBqxgs3i2Q555yb+SDe+2A/cb9q/ExLO4+82cT3Wrlf2ALWO4lvezWLLfGaisC3X+LP/G2uBiBNboYq6iy+who+xa+7LTb6qKvhm1gfZ1hMFSBUL50wGmxa17u9jn+n0M86FR/MeddtXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430290; c=relaxed/simple;
	bh=SwK3bcRINUYNvg75ngkQuCC9YwxwSNfmIjCVn4CWU5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nYvh2Lf2jVKk7U8WHiItWPP3O1B/mbYNYDVIn5/WMhG8WeD72WEaMG3i/9vMCMV5n030Ou3yPN4Ny9RlYzHjvA5xwXevf1eAmUPIAiexuQzGPPTRcCrbJCBN8lkc8DSug+sK1Ph/cpzGxyjTObe1NBpNd4jgiR9L2lgDB6dOZOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=oJPjrpOZ; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="oJPjrpOZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udk0vC+te2JrEfid9R73e43tv220fS0PQJ/OJzq2Cuvie5sk6+gsDZiWS1c+wGlb2BEZF/Crxg8n21H38yKc9/ON0JiN6AG1ArXVUdLnYCvnYaZvXkruGDHosGiB5pgexJwztmGIoTvkBxvcsh/f2byRzUv79YbDd/M2IjY3IotzLgoAJYnBcMdiWwY7RDU0LN9WXIar/bC8cfNK9WjjMLEK7oJSZVE2Ru7RLMFNskCxpZkdQl0UO1lNLtvs/3QbM+Hr6LAQvJDLTxG8qV9GmYiP836l1JWA2+9zgixF5WH7pwAu4WyGqup3NnwZdZMw5xxQnsOUYAkSrcc5biGv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwK3bcRINUYNvg75ngkQuCC9YwxwSNfmIjCVn4CWU5s=;
 b=g4ockr56bQMohdjHf2qtLwHBbGfjyHuohgy4vTGjWaAeThHdRwWVxqEjcfzE2NC32PhTE+d3gjYw7UUgVreYfaoBkFo6dTNGRwKQDhQ4xdjBdrL94jktttGzM9kmq4+Dfvnolsly8KJ+ZeqgU/LnXJ6sRoVexUudiOSJn6ydUUiMmDsWS1SldPO5w7oZ48hNNJMSO+LukMclQXO9ggE+9AaDG1OJG4aoTAuCSYoPCplgIB3HWwSPnEg1mp29VBavVg+Xqwc7bwcsk8k82aFO+7u8llfgcqGwFqxKr7mce3dyenEi5pw38ddtwvgzmwNtm4CBjj4OstbYEC6BGBYITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwK3bcRINUYNvg75ngkQuCC9YwxwSNfmIjCVn4CWU5s=;
 b=oJPjrpOZgwlRdo6Tk2H0ATzrfk4zoeJA+K9ApXsC20XQpz1E4qvSL5MzfEIKHjsqG/rbmqski697UhC8I0g7FMMyH3djzsqFlkTW+PWhlU/pvI/ooSOuJFvpAbtVNNSCbxTMt7sLHrRAooniZh9fEMwBjpvE2Uzov8I+35m7hSssUDm725BfAwwd8bgi3dt4s9ixmOiEHaQ8DynSD21hAPUzoLz07YYwWNORWLlYwd/o3jm+n53M5obANU9YWdGYse2Ji/xhrxJZXncbS0VpMGrAWmNZwOdh+kG2zY/0JYdjjpuV0FdrUYW2JW9/+J4e2eQ4UKBihmI5ZGviZIpl+Q==
Received: from AS8PR07MB8117.eurprd07.prod.outlook.com (2603:10a6:20b:370::8)
 by AS1PR07MB8480.eurprd07.prod.outlook.com (2603:10a6:20b:4dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 07:31:23 +0000
Received: from AS8PR07MB8117.eurprd07.prod.outlook.com
 ([fe80::9829:72d7:16f1:dc8c]) by AS8PR07MB8117.eurprd07.prod.outlook.com
 ([fe80::9829:72d7:16f1:dc8c%4]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 07:31:22 +0000
From: "Ismo 1. Puustinen (Nokia)" <ismo.1.puustinen@nokia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: RE: Two kernel oopses
Thread-Topic: Two kernel oopses
Thread-Index: AQHbvY+zKAgMEMin5ESJGUeIkEsoyw==
Date: Mon, 5 May 2025 07:31:22 +0000
Message-ID:
 <AS8PR07MB8117A3691C47282505D326B8858E2@AS8PR07MB8117.eurprd07.prod.outlook.com>
References:
 <AS8PR07MB8117D39772278625220157B085A12@AS8PR07MB8117.eurprd07.prod.outlook.com>
 <20250331063139.WHL_PGTC@linutronix.de>
 <AS8PR07MB8117432C9C7C051F57D7495485AC2@AS8PR07MB8117.eurprd07.prod.outlook.com>
 <20250401121645.qhxReysh@linutronix.de>
In-Reply-To: <20250401121645.qhxReysh@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB8117:EE_|AS1PR07MB8480:EE_
x-ms-office365-filtering-correlation-id: a2cbe777-dcfb-461e-03d2-08dd8ba6d5bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3NMZGpUWUx5MWZtUGFucHA1cUpvWkFhdU9TR0Zha1hMY2pzYXpYUGxRNzJP?=
 =?utf-8?B?OEpITVgrZjBxSzkrT3lwb3Q4eFVmZ1Q5WW1GbUVrNUdZVkM4OTRqd25nUDN3?=
 =?utf-8?B?NjRkcDBXUTlJbENFQnFqK3ZhcDliNVdiTkhxWG01QUVDU25LTlpTWEtidlRw?=
 =?utf-8?B?NC9XTFp4enNpOGJHbzJidWJ4bnI0c1NHUWdxMjZPcVNXYlIxOTJKV3pSNHdk?=
 =?utf-8?B?eTVkc3dLN2ZXUzdoRGU2Qm9SQnpCZTJKaVFINldLR2dSOFNFUjZSSHJ6K2dL?=
 =?utf-8?B?M1d3Q0ZYS3ZwbTNnZW1pWU5MMGw4VDBaN3dSK0pSdEQ0d0h4S1JETXlhUUwy?=
 =?utf-8?B?aHMrOXVJVDM2Y3liUWxXR1hUL0piY3I5L0tzbWFWWVZFUitQdEFhd2pyZjlE?=
 =?utf-8?B?dy9qRWpoL0FMUHo2WDl4a2R4d3dIcEVSOEowS2N2SEwrcHhOcHFiclFYU042?=
 =?utf-8?B?WFp2WXpQbmVUQnFiQVpVZWhKU2U2UEJCN3V6YWs1bGdML0QvVHFENzNhSVF3?=
 =?utf-8?B?NVAxYjQ5TCsrdThZdVBjcHNPcWY0SzFnWTNrMWwzaElPQWhVdXRaOGErUFFM?=
 =?utf-8?B?UElTQURLZmVXRkxJNForMlRuUXRuWHVTVnVZUTZ4cXJvMGxMMlhQWDRqbjVZ?=
 =?utf-8?B?RGFZSGZHMWxUVEliR1hZUmJZUDJSZDNRWFVzVW11b2d6RDRnUVZaa3JyRTNH?=
 =?utf-8?B?UEE1dW5xaE5RcVI1dlpPcFE0N3RsbW5wNVduWlRyaWtieUxBc0hXdzZMNE1t?=
 =?utf-8?B?Q0ZuS0hFYkh4aThwa285ZzhCSWFzb2wxb2ZTSFJ3aUIxbFl6MGpYRDhnaEVh?=
 =?utf-8?B?Z25ONnhHSjdYSEpFWDRFNHVKWUhHUUFCdG5yeGxkSm1BWVJMdW9JRVNvRDVh?=
 =?utf-8?B?bGpMUlVpVi90V1BJbjN6ZW5MYVlsVjd0bE1YVk5tLzFPSTdVbnZNaStuZlR0?=
 =?utf-8?B?MmwwR1JvY0VaWTVXbVpiLzVjaU91aC9OcHBJaTloS1hsQlBMS0VHdEk3M3pX?=
 =?utf-8?B?MGdGb0hCYVpUdllvYjhlRzdHOWUzbmNDMFdKdWY4Q1FCWmowaGVoWEZwRk52?=
 =?utf-8?B?NTVjZHpkb2pqdHdpOXJnMDYwbTROTTBMOS9ZcGtRNVlkOGlMVFIvZnRlN2xj?=
 =?utf-8?B?YjlBM1RXZHdWZFFXYkdCYmJZcnhLV2tVSTB2ZFVmcXdYUnRnMTdTS1ZaZEVF?=
 =?utf-8?B?WmI5ZzJiNDVONWd4SVhxL05SSVZpRWtMekZaR3pZQ0tteldUdDY0SGVidmth?=
 =?utf-8?B?ZGxXVDBPN2duTUlrTlFEUVlDZDRySnJtYXpQSG1vc1h6em9DZUNPMDBVQnYw?=
 =?utf-8?B?aWhUM2NzUEZIckU4ZU44T2lnRWdTazlHNHZCS01zdXhUQnRPWm5CMWYxaFZq?=
 =?utf-8?B?YlJyeFRHSGVDaFNLVkxxemtDZVl2S0tmYzEyemhMbGQxZEpCQUdqUEFoYisw?=
 =?utf-8?B?cW16M1kzaTJpaDhpU0VvSDZOOUMrVnJFSUx6a1FDL3Vqcm5CWHNIMVo2NndP?=
 =?utf-8?B?dmpwNFVXdnJHcWRHRGU0K3FyRG1KMU56VzFyOHkwL3gvT1pxTElYYSt2WWIx?=
 =?utf-8?B?M2x0cHBLbTdINUFGUkxWMnVjNkdlZmN2aFJ0cFg4WFd6bm8xeDlKS09QRkto?=
 =?utf-8?B?amhHQXFzbXRaK0YvM3dZQjd4MXFWS0FabWJ2SnpCakZNMWlXVmoxTEJnY0xt?=
 =?utf-8?B?dFZ1alRjYjZMd0U3N0NEU2hyNmFwVGdPZEt0R1RaUlJ4aDFpeFVtMWZlcU1D?=
 =?utf-8?B?QURsRmNiTmRJdDN1NXdIZnVzcEw2cUhtK3Y1Yno4TXB4bCtJVE8yVUF5VnM3?=
 =?utf-8?B?eElpdDhtNTJtQVVlMmpGcGZGM09jd204cERKYmo3akNqSTZ2YWowOWo3L2Jr?=
 =?utf-8?B?NGN6ckFWcUtGL1pwRFRUR0dyRGZqcXlwSVVaQVBEZUdvckM3OEtLbTdyd3FN?=
 =?utf-8?B?ZHhDaDI0UFFvd2V0b1dwd0lEWXZGUXYrR0FZYXdBNXk4U2tNZ2xmb2k0cXpy?=
 =?utf-8?B?bzB4SXJMKzRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB8117.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2xMZzM1U2Q4YWN3dUJyMTk3NlNBcDQ3RTM5K29MOXRTMzYzMXZJaldSZ0Zj?=
 =?utf-8?B?WFFHVzkxaEpGUDBoc2svMHRUN2dnQkZZdUlHUjZNZzRyVEExWDArWkJZYUZu?=
 =?utf-8?B?bG84eHluQlhVQzEzY1lvZTRIVlBJcEhXSHI0RnNrSlo0S092L0lNRnZtZDVh?=
 =?utf-8?B?NDV4dTdMVWtBaC9XUmwxSmJ0TCtneHo4aDFZTi9JblNKaXNIVDVQNzQwemYv?=
 =?utf-8?B?OXpCd3FNSHFlMVRnSGpmbmlKL21wWGQxQ21CRHAxMnNkaW1FUDlVenltQWF5?=
 =?utf-8?B?c2Y5dGswSUs1MnI4MUFOemlhUHdLeUtpajJzVzYvSmo3UDltNHZPOTQvbUJq?=
 =?utf-8?B?NkZYQ09oU2pXMVVvdThnWGJUVTZnbE1Na0ZMTk5LeUNzWjRjZWhTM3ZBOTRx?=
 =?utf-8?B?M29EZTJmK21OdEZ2a1c2eTRIZDgrK2Q5SnJZYlp0NUdlVXM3OExBS0g5SWFK?=
 =?utf-8?B?ZTRONWg1WnF1bUVwMHJjZExSdUF5LzBCS2x3NWVtU1FNWW0yM3dyNnhKZlIx?=
 =?utf-8?B?Vk9aa2kzZnY2YjNNZElra2dtbU8relQ1a3NIeEUrd0psb0xjaFoxcUthUkZ4?=
 =?utf-8?B?bzM1WGJGQWZJUFF4NVVydEhTMmszeloxQ1J2bXBlMGtwVURQZ2trM2NybEEr?=
 =?utf-8?B?d1RodlhFWVZMVmJFemxGbTBpbnZMdnIzQjJmdmJLcU41a0ttTnFBenc3K1dn?=
 =?utf-8?B?eFN2VDlid1E1Q2JhYzVQaTJpdjY2b1doWEpqaitobTc1U1h6Y1dGWDJPbno5?=
 =?utf-8?B?QWJ5cHZDR0dUaCtBWlYvNE41WlFOUW9NVG9kQkhKSk9nekd4TWEraUUwN21K?=
 =?utf-8?B?eWQ3dzNsMjhRbUxyMjVDTFBwY0p5Ukx1SXllUTJzeHVURm9ydG0yN2wrWDJq?=
 =?utf-8?B?RTZ6ZmR0elhyVTM1WnIwbFg5RFdVbUxONlBwaXlDcERyUndMZlVKbm5uaFNQ?=
 =?utf-8?B?WFFGc3dFZUh3NGxqQVB5OEdnUnRTNTVBTFFWVGhieEtOcElhZlN3bTd2REor?=
 =?utf-8?B?dVZaMHNFTzVNSXVrRm51cHJWQTVhamhhNVZTRzh1c1ZtdUdYbGovaGY2QWwy?=
 =?utf-8?B?aHJvMCtqenNMT2pjT0t6UWJhcm8zeHpnYjI2NUppeWFpWmxic2lWL1h3dFEr?=
 =?utf-8?B?KzBRWkphTFRwTlE0VnRxaDRqMG1TZmNRTG9NYmJCRmpEai9QV2lCVFIrVW5q?=
 =?utf-8?B?NXN1bFIySDlpd0xmS0Q5ZWVJenRSN29PQ0IwMzQyKzBER3piTUdHcE1uaWVt?=
 =?utf-8?B?ejRSWS9iSmFoMWR1Z3FQQ1Y5MFMwL3B6SGR6ZUVaV3Z3WlltNWg0N3NoN2Mz?=
 =?utf-8?B?b3RjT2lJTDZ6N216ams5M2dyV3YwSWZQQWN2SW0rTXoxcGdIc3UzMXhUWTho?=
 =?utf-8?B?V3BzUkkyTXBvbUxDV1NVRkpyU2pKZ1VjZzNXQk82L0x3TWpyNGhOZlhLVGEz?=
 =?utf-8?B?ZVgyZGs4VVdrMkcvSnNyaEFvdzJPOEpxdmxrTzVWS0ZOOUdtY0MzbkdrVmZr?=
 =?utf-8?B?dU96TzVsaUxFY1NlamQ1VkcwaHJYTmpmbmxpVGd2ektqWnlGMkV3aWZtRlpu?=
 =?utf-8?B?KzRTVUxLOG9nZ1h2K0prMFVRZGs4c2REQUs1UzFzM0RzWXlsaUlQZzlwV2hR?=
 =?utf-8?B?Yld1T2V0bXcrNm43bWpjajE4YzlYa2hVb05uY29IZUE5YnYwbnNDcTkwRzZI?=
 =?utf-8?B?endpR0Nid2hCREZJWGNkYlEyZWFHczNLS3BXbkxJbmUvNVdIRncyUGZjeWFJ?=
 =?utf-8?B?NlN1Qk9XQ1BRMUxCc25wajBxbXRQNUxNdXdHN1VITVcwWVVkYjU3ZFhnTU9L?=
 =?utf-8?B?NHRWQXhya2JPOFFHaUo2bEVJSGR4YkZnSThFemlpZUY4VlBRNjkwZUE3K2Iv?=
 =?utf-8?B?Vnk2RjMrMWFGbUx5L3BCOWpzcE12eXlIeURvVUFwcDFsZE50WEFUQ3RCZmVI?=
 =?utf-8?B?Y1d4ZDZYZ25PMnhkd1Q4QkNacEJMbUlDeFNoNGZFd3lFcWtCR0lUTTlYdWcy?=
 =?utf-8?B?bE4zM3RPKy9SaHdleDhPbHZENEhScmRydXE5S3V3Q1lRMElVNjFxYnlzaVhh?=
 =?utf-8?B?ZFREVzlFcEtqWlRRQTFobHc4R0M3RzVvcnpXRUpITVY4WkJBbUIzQ1RHN25h?=
 =?utf-8?B?YUJidjJabnVyS21Lb1JIM0RuY2hseml2NlQreDV2YTZjbXJLZWFFRGZSUGs0?=
 =?utf-8?B?akE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cbe777-dcfb-461e-03d2-08dd8ba6d5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 07:31:22.2912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwMw48FL54fLdgOytmp8A5Mh+4/SvOasi4lajXn08zQPWPQ+/Nl0WTUriYfVW2VHG2pi6EvUBB5PuzxXmAb6hfAiaPjl7+3LjB1JA/j70Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8480

Pj4gVGhlcmUgaXNuJ3QgYW55dGhpbmcgc3BlY2lhbCB0aGF0IEkgY2FuIHRoaW5rIG9mLiBUaGUg
Y3Jhc2hlcyBzZWVtIHRvIA0KPj4gaGFwcGVuIG9uIGEgIm1vc3RseSBpZGxlIiBzeXN0ZW0gZXZl
biB3aXRob3V0IGFueSBzcGVjaWFsIGtlcm5lbCANCj4+IHBhcmFtZXRlcnMgb3IgcnVuIHRoZSBy
ZWFsLXRpbWUgd29ya2xvYWRzLiBUaGVyZSBhcmUgbG90cyBvZiBwcm9jZXNzZXMgDQo+PiBydW5u
aW5nIG9uIHRoZSBzeXN0ZW0gdGhvdWdoLCBidXQgdGhlIGNwdSBsb2FkIGlzIHNtYWxsLiBUaGUg
c2VydmVyIA0KPj4gaXRzZWxmIGlzIGEgbGFyZ2Ugb25lIHdpdGggNjQgY29yZXMsIHNvIEkgZ3Vl
c3MgYW55IHJhY2UgY29uZGl0aW9ucyANCj4+IGFyZSBlYXN5IHRvIHRyaWdnZXIgdGhlcmUuIFRo
ZSBCSU9TIHZlcnNpb24gaXMgcmVjZW50LCB1c2luZyBhbiBvbGRlciANCj4+IHZlcnNpb24gZG9l
c24ndCBzZWVtIHRvIGFmZmVjdCB0aGUgaXNzdWVzLiBBbHNvLCBmb3Igd2hhdCBpdCdzIHdvcnRo
LCANCj4+IHdlIHNlZSB0aGUgc2FtZSBjcmFzaGVzIGFsc28gb24gNi4xMi42IGtlcm5lbC4gVGhl
IHJ0LmM6MTAzNSBjcmFzaCANCj4+IHNlZW1zIHRvIGhhcHBlbiBpbiBib3RoIElSUSBhbmQgVEFT
SyBjb250ZXh0LiBUaGUgY3Jhc2hlcyBoYXBwZW4gb24gDQo+PiBzZXZlcmFsIChpZGVudGljYWwp
IHNlcnZlcnMuDQo+DQo+IFNvIG5vIGV4dGVybmFsIHBhdGNoZXMuDQo+IENvdWxkIHlvdSBidWls
ZCBvbmUga2VybmVsIHdpdGggQ09ORklHX0RFQlVHX0FUT01JQ19TTEVFUCBhbmQgY2hlY2sgaWYg
c29tZXRoaW5nIHBvcHMgdXAgaW4gdGhlIGtlcm5lbCBidWZmZXI/DQo+IElmIHRoZSBjcmFzaCBo
YXBwZW5zIHdpdGhvdXQgYWRkaXRpb25hbCBkYXRhIGNvdWxkIHlvdSB0cnkgdG8gZW5hYmxlIENP
TkZJR19QUk9WRV9MT0NLSU5HIGFuZCB0cnkgaWYgdGhpcyBvcHRpb24gY3JlYXRlcyBhZGRpdGlv
bmFsIG91dHB1dD8NCg0KT2ssIEkgdGVzdGVkIG9uIHR3byBrZXJuZWxzIHdpdGggdGhlIGRlYnVn
IG9wdGlvbnMgdHVybmVkIG9uLCBhbmQgdGhlcmUgaXMganVzdCBvbmUgZXh0cmEgbG9nIGxpbmUg
KHBzaTogaW5jb25zaXN0ZW50IHRhc2sgc3RhdGUpIHRoYXQgYXBwZWFycyByaWdodCBiZWZvcmUg
dGhlIGNyYXNoIGZvciBib3RoIGJ1Z3MuIEkgdXBkYXRlZCBhbHNvIGZyb20gNi4xMi4xMyB0byA2
LjEyLjE4IHNvIHRoZSBhZGRlZCBsb2cgbGluZSBtaWdodCBiZSBhIHNpZGUgZWZmZWN0IG9mIHRo
YXQuIEknbSBub3Qgc3VyZSBob3cgdG8gY29udGludWUgZGVidWdnaW5nIHRoaXMgLS0gaWYgeW91
IGhhdmUgYW55IHN1Z2dlc3Rpb25zLCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNCkkgd2FzIHJ1bm5p
bmcgdGhlIHNhbWUga2VybmVsIG9uIHRoZSBzeXN0ZW0gd2l0aCBhbG1vc3Qgbm8gcHJvY2Vzc2Vz
IHJ1bm5pbmcsIGFuZCBkaWQgbm90IHNlZSB0aGUgY3Jhc2ggaGFwcGVuaW5nIGluIGEgd2Vlay4g
SG93ZXZlciB3aGVuIEkgYWRkIG1vcmUgcHJvY2Vzc2VzIHRoZXJlLCB0aGUgY3Jhc2ggZnJlcXVl
bmN5IHNlZW1zIHRvIGFyb3VuZCBvbmNlIHBlciBkYXkuIEkgd2FzIHRoaW5raW5nIHRoYXQgSSBj
b3VsZCBtYXliZSBydW4gc3RyZXNzLW5nIG9yIHNpbWlsYXIgc29mdHdhcmUgdG8gc2ltdWxhdGUg
bW9yZSBsb2FkLCBpbiBjYXNlIEkgY291bGQgYmUgYWJsZSB0byByZXByb2R1Y2UgdGhpcyBmYXN0
ZXIuDQoNClRoaXMgaXMgdGhlIGxvZyBsaW5lOg0KDQpbMjc4MTEuNzg5NjMwXSBwc2k6IGluY29u
c2lzdGVudCB0YXNrIHN0YXRlISB0YXNrPTE2NDYxOm9wZXJhdG9yWzI3ODExLjc4OTYzMF0gcHNp
OiBpbmNvbnNpc3RlbnQgdGFzayBzdGF0ZSEgdGFzaz0xNjQ2MTpvcGVyYXRvciBjcHU9NiBwc2lf
ZmxhZ3M9MTAgY2xlYXI9MTQgc2V0PTANClsyNzgxMS44MDgwOTddIC0tLS0tLS0tLS0tLVsgY3V0
IGhlcmUgXS0tLS0tLS0tLS0tLQ0KWzI3ODExLjgwODA5OV0ga2VybmVsIEJVRyBhdCBrZXJuZWwv
c2NoZWQvcnQuYzoxMDM1IQ0KWzI3ODExLjgwODEwNl0gT29wczogaW52YWxpZCBvcGNvZGU6IDAw
MDAgWyMxXSBQUkVFTVBUX1JUIFNNUCBQVEkNClsyNzgxMS44MDgxMDldIENQVTogNiBVSUQ6IDAg
UElEOiAxNTkgQ29tbTogcmN1b2cvMTYgTm90IHRhaW50ZWQgNi4xMi4xOC1teGllICMxDQpbMjc4
MTEuODA4MTExXSBIYXJkd2FyZSBuYW1lOiBIUEUgUHJvTGlhbnQgREwxMTAgR2VuMTEvUHJvTGlh
bnQgREwxMTAgR2VuMTEsIEJJT1MgMi4xNiAwMy8wMS8yMDI0DQpbMjc4MTEuODA4MTEzXSBSSVA6
IDAwMTA6ZGVxdWV1ZV9ydF9zdGFjaysweDM1OS8weDNiMA0KDQpJc21vDQo=

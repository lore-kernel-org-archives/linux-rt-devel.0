Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE294C62
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Mar 2025 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743065783; cv=fail; b=UjgXCWrS2xFiRu/eH1/ZVM/hpaRp6tcSQdiVBbcNlwCs9gdUHzB4dabJqw1yj6mSoNQnyXUhFcQe2bbVzXlvJFIOWuER+sQ9Bh19OpzbmTCWYjWOziMKCheQKOyB/WeeAZVDgNQMFiQprcA/UjdKAULI0881h3p5P36HuG/h05s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743065783; c=relaxed/simple;
	bh=4tiYuA/WzDJ3B7uDhborCpV4fQUMd5F/UbxbM6kEj28=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jxxqWlapFX3BJqQRHBPrFyfYkczYkr4I4uZL7M0gdqrd1UjTwXL1pOSmejyB+g5sDaJ6OYkFSkU6kVfb1f08QK3hAZuUVkmjN6N+FaEat5Zqn0jUrxZqzb7ZuW7HwrYHowSnX39uxRDe5V0SkvbfPlBeiYLIic16BGQ9w2sL3rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=lWNy1KUA; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="lWNy1KUA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0mwGre39MD8QrqkQBKkGN7e+1xC94dtLp0I3vItwXdzLPTFTmixpcfewsGTwEtmr8FqHFDczKAwlWTQj9iI9ptoUJ/u/wRIklZJ3ccrZo0bsAkYvENK1phbUx9pn+B58tEshR3418M8PmYPb+37ZZhdNb+PwOosBAaHVx2aWnDBo2aRuBcnCJ8b//B/grKsMbvUSKnhddSQs7uhKskQ5s7ZBwMG5z3F+fvbQGliBtWoNXSShyxzelfkaVzhk/dr7BcAmxpiPlOK0b0ZCrWB4NnFUTgXcSTbuMjw8d4PM7slrJhO9bclBk4p5k26y1leM458pUKKmiRsm3e2WuB6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tiYuA/WzDJ3B7uDhborCpV4fQUMd5F/UbxbM6kEj28=;
 b=xdEGxgFMWvAs4gu2XBTwVRwvdq8pN8pnjLJF63lQxgm09+7bF0KI5msDd/VcjqmsyQ2nuLif3Eyp95HjFD3EjAPmUXZm6SW7nfJmWbPHxIc/+Zx5jXQ9225rjMMqe53dSIFggsA2LGBoTCqmH2HDDUkh24JgJ2NWEprTJxcQJYJ2Y1GPuXAbBK+R3+/gnpSC6806AlUP7741mc5ZnGBt0JRlHtmyQvLWQwy3QQiITN+dYzVVvvSR9t0/LiqcnlVy9C+MJVM3XPReX5wipqChfPRzSjSWNV4xJLB70ORnEkVf0/UHQvwKglFqT6LuGyuWRfhvnidLoA5xKkVUZAbRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tiYuA/WzDJ3B7uDhborCpV4fQUMd5F/UbxbM6kEj28=;
 b=lWNy1KUA36sTvNei/E8oz4NAUkbLnQhnow7iepruyYOrie+lhAjHnWAuDgUbtHU8yOOXdydEuHH9RaSPMdzFKFNMhwxy2XBDETRRsnYj8loiN/cketwQXQK0+E6l7seP0PXoo/yOz1nj4aKIF80reza4Avk9xoKoVA5nszkPkePUSUdKRJ4XRXjsR2HXn9kPUUXBHDj4QOvTL81bWxlfEjkk8Yh+pAnfIwxySKOQmU29ofCgCEcQCWUzeXYH7sje4tHFH55BEOqnm2AkUQunGA5lFZfwmEJ1YeJvolVB09WNvrqFdKDuhGO4IvcMEiwZ/W1eEa/TyqH3SNeY33Tg4A==
Received: from AS8PR07MB8117.eurprd07.prod.outlook.com (2603:10a6:20b:370::8)
 by VI1PR07MB6607.eurprd07.prod.outlook.com (2603:10a6:800:181::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Thu, 27 Mar
 2025 08:56:17 +0000
Received: from AS8PR07MB8117.eurprd07.prod.outlook.com
 ([fe80::9829:72d7:16f1:dc8c]) by AS8PR07MB8117.eurprd07.prod.outlook.com
 ([fe80::9829:72d7:16f1:dc8c%4]) with mapi id 15.20.8583.027; Thu, 27 Mar 2025
 08:56:17 +0000
From: "Ismo 1. Puustinen (Nokia)" <ismo.1.puustinen@nokia.com>
To: "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Two kernel oopses
Thread-Topic: Two kernel oopses
Thread-Index: Adue8/Iya5phMHMuSUK9E+foAOfLhA==
Date: Thu, 27 Mar 2025 08:56:16 +0000
Message-ID:
 <AS8PR07MB8117D39772278625220157B085A12@AS8PR07MB8117.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB8117:EE_|VI1PR07MB6607:EE_
x-ms-office365-filtering-correlation-id: 45d4d71c-e3db-4cdc-4a5a-08dd6d0d3c4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGNreURCRzBGMGlXM2ZCMW1xMDkydG1yakFoSFpqUEQrVGUxcitualhmUFlR?=
 =?utf-8?B?MVZTU2xmTzR1SU1ibXh4Z3dZSzA2a0xudHlScWlVaFp3T1lyaVBOdDBKUFB1?=
 =?utf-8?B?SFBETzFmRkxsUksrMHFyTWt2MUhYdDNTVEVrK3lLR25mR0dobURhS2tYRUEx?=
 =?utf-8?B?UEpEMzVNak5ZNGdQb2d0ZVZwbkI0TXRDRFJDb212cWlQM1FzOWh2NXo2QlBu?=
 =?utf-8?B?Z00vbUtLSDFTWVFyZVZvRjhKSDB2eEZNd2JQUy9RaVBOc1pzNGhkYnBKQ1JD?=
 =?utf-8?B?Z280NzF5ODc0UXlKMGplczJZRTg1UUlVdEZwNmR0NlNkQ0ZNa2NlYzZ3SHdo?=
 =?utf-8?B?S2R3RjhMd2k5dUdrdG10NTdqZDhRNk9qTGlsS1hBTklmczRUUHY2TTBYclln?=
 =?utf-8?B?eEY5RFI0bDhLaWRBb0FpOTB6UHB0cGljSS82WnFrNGRPU0l2cStyMFBvdDQ0?=
 =?utf-8?B?SllkeWlCZ2dOcDNER0VQcWFHK2pVTU9oUjhtLzFOUTVSaGs2aDVoLy95TktD?=
 =?utf-8?B?WDRlNnI3UzJGMGwwMmZ2OXZlSUlhVmRvc1dpUUR4TkNqY3BxU0QvTUl2TUs1?=
 =?utf-8?B?aHZvVUNFbFFic2FzK2pOVEFBeEJ1c0k4blU1b2tITHJvUGNjR0NqbmVVMG4w?=
 =?utf-8?B?Z1hBREJnWEZycDZXSm80NnFGNk5TUGtMMWo3WVBiVlAxOGNJUDRPVTE4cDhx?=
 =?utf-8?B?NDZDUFRMQ1RnaUVBeldOT0Fnc0hFQnIvS2ljcTRKUXRvOElWWS8zQjBtUERD?=
 =?utf-8?B?eUE0MjY5RWpVSWRQUjQ5NzVyeFZwVVc5M0dnbHFGYjJtM0J5a3pjR1d0dFNs?=
 =?utf-8?B?NTlPQWpLZDJhNFNHRHhoeUpvdFd2enE2Ty85RDlzVTVVWmF2WEh3UE1jRHdm?=
 =?utf-8?B?bEJYaTZVRzFYUEZaNnhCUmd4cnpMb2ZpTGc5aDIxbWRLemNRc0FmbkNGemFX?=
 =?utf-8?B?aTJWMmZBWlJnd1dvZTVzQ3FJSzZhQjdNNEFjYUMwbnZUVXRKOW9QMWl5Nmhj?=
 =?utf-8?B?M0ZXYjR0SVNUb0t4a0JLRFJ2K3BSVURQUEhwK01DdDJ2OUhJUGhNekVKTDZJ?=
 =?utf-8?B?UnVMZjl3Qzc0bUxwOFNUcUwxbkx3Mk1udTJPVWpFbm0xeDA2QXJiblJUNjJM?=
 =?utf-8?B?eDNDM1VIRjhTZUMrdzd1cVJWbE9xNVNzVXpIclhNQ1RqT1dKN0tqUnJGUkVK?=
 =?utf-8?B?VGtxeDRYOUQvdmh5K0VSUjdtOE9EblU0ZER3VUgxYXloZG1zM2E2YjA5QUZv?=
 =?utf-8?B?RlAxZ3ZlaE1xRVYxUUdBeHpUS2ZuV3lWTTBjeDFXWkttK2YvaGV6R1FFdVpk?=
 =?utf-8?B?VG56ejRIdnpTZVcvU0dwOE9vTkMxYXJzMCtIQTNoa0o3aFROM2dWemVvazZk?=
 =?utf-8?B?QjFDU2Z0d3VKWjgwdFhTTzJNblBRMmwyK0oxU3dEdU4vZHZYMjNqZU1ZK3Iz?=
 =?utf-8?B?N0tIdVQ1Y2FrZDd1THZpOXFuSENITFBXdHA5WkpQQUVQejNabDEwSU5ESFdh?=
 =?utf-8?B?N3FsZkhLeWlGc3FmQktRY1dUTzVhQkd5dFhyQ3VXeGlkYnJoTmU5ZG9rMDI5?=
 =?utf-8?B?czdac2xPdzJhQWRBOXhFZytMWkxZMStWL2VYeEVDckxiKzA5bFltMzdRNExv?=
 =?utf-8?B?UjZMcTV6RjNoNHh6aGFpVldKOVpoMStUaUxKVFcxQzUzVGtBS3ZacnN5YUFJ?=
 =?utf-8?B?N01neS83K0JudFI3UjlYeHJxSmZmanhBU0ZLUkh6MVIwcHpicVNpZk1PRTVV?=
 =?utf-8?B?TDdRUklkRzBQSk1UUUwyME12MWtMd2w0aE9lOU5vaDlzMDREL1ZnNzFEYSs1?=
 =?utf-8?B?N2taSW9STGNUQklSMlZIMDJTVXlkdFR0Yy9ZektjTmlyN3h1SEVwNUY1ZGNh?=
 =?utf-8?B?NjV5cDlLcVdkaUNEa0J0dEw2Z0dxWjU5L2N6UnE1ZXdMdzAxYXNpalJwdmI1?=
 =?utf-8?B?WTR2azh2VDR4NFFWQ3dkaGhPUnZqNDVmdEVwWkNmbXJPblZNdDIrUEV5a3J2?=
 =?utf-8?Q?JAsnVGz9rZ+bpWn+TqL+dngVlqiuL4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB8117.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWViQUowcld2NHR5RzQxOGpIZnlqUHg0MHBPWlp6VXV6UEdBVG0wL0hCMWJO?=
 =?utf-8?B?RkpBbEtIQnJxQTdaVHMvSnFQdzdJWEIvOUZxcEFoMWc2WW56SjZPcHFwYXVl?=
 =?utf-8?B?blFOY1lTamwvSDV3MkFtT2tiRUtuV0tGRVRScnFIN0JJSzF4T3VFc1JOdWR2?=
 =?utf-8?B?TmlzcERBRDI0bjZEN3NrNit0THcvVDJpelFnWHYrbGJqYVNQbU1TMHpXaEhx?=
 =?utf-8?B?V2V1VzBvMVZxaEdGdnRDbGk1emNQMkNSQ0piM2dpandCaFlPeEU0Vkh1VTc5?=
 =?utf-8?B?eENwYWIxL0RHdWwxSk4wU3YxUC9PMHhSK2Jqa0ZQeEJKNXZlYnJIL2FIYVRp?=
 =?utf-8?B?TnpnME84MW9SR1FDQ0VKbnE3eVpvQWhHRU1VbTk0Z08zdlJxSTlodDRxYm9v?=
 =?utf-8?B?MmVCY1pkZG9tTUVCUFdFay9CZjNTazNrQlhvV0dzWEhQMk9RVDV3YzFzam40?=
 =?utf-8?B?ZmZHT28vNHQxTTk1VHJiK0Z4dUwybXk1elQvQXlHMDY5MlZGTUtSNWRkaTVr?=
 =?utf-8?B?UlhNUlRRSWF1ZWlmN1BlN3ozUXphR0ZpWEx0WHlWZ1oyc2hIMDV6Yy9DN082?=
 =?utf-8?B?SWFyWmk1S0FpV1JEMWc1UjRTM0pmc3IrWDg3MG81L3dPU2cyYTNVbEdKYndB?=
 =?utf-8?B?VjZlVFZPWlVZOUV0WE1mdUl5TElYbTZYNk1OcFhHVHY0QUMwUnAvSGRvWnc3?=
 =?utf-8?B?elBqYytEV1lMeGZDckpmZmxtOHNiUUI2cHMzbW5zdzIyUEd2NVZVTmNsaFJ0?=
 =?utf-8?B?Qis3aHFRWVFyQ1p4dEdJU29KaEE3VDJtblpCQmZ1ekNlMHhSUllQaW5seWFR?=
 =?utf-8?B?OUJWYlJQYktSeDRRTHE3akp0SlYxY29nQnZ2dkxET2UwVVJUOTUyNUszQytX?=
 =?utf-8?B?TXNsbHh5bVVKVVh2dmptWkowZWRvalVHQVlOZnpuTmV0MHZFTVRKY01SVE9R?=
 =?utf-8?B?eDhuUStlUnhsNUI3a2FJZTB3Zm9pQjRYeW82U1l5dXJXcEc2YVhZblB0Szh4?=
 =?utf-8?B?Ky9TeDRrMEU3NnpKakRLN3hJTmF2b0czMExYTTF0NjVIZnZ3cGhjemRZUzJa?=
 =?utf-8?B?U3lqRGxZckk4d0ExZDZiZGR1NEtmSUlNK0hpL0MyekFoOWg0cjRjSXJZalEv?=
 =?utf-8?B?UEUyYWRYa2R5WmtqQWVsZlU3eGpEckVZT2wrUFVIU1k1dGEva2FOR0JPb1FB?=
 =?utf-8?B?RnFLWDBrczkwOFY5R1l1d3lRS0Zka09IajZ4ckIweGYzR2luZ1A0R2VvM2lY?=
 =?utf-8?B?T1BndllDUzZHOWl0TWVYNkJORkNMc1hlRG91NWdZMWY5L2dNR0UrQXpZaFhV?=
 =?utf-8?B?V3FZV2N1SmZFVHZ6aDc5VGxIaHZBMkRGcEJLT1d3ejZCcE56UFNmL2FuUWNP?=
 =?utf-8?B?NDNPM08zQnYvS2ZyZzR4b1Nvam1Ra1lCblRZZzk5N2t6eVRlWDhYNjBZUjAw?=
 =?utf-8?B?VmNJVnV2cEZQR2JaOWpad0JDbUJRem8zZDhscy9POHRaVVdraXNwNytQcXJZ?=
 =?utf-8?B?RzkzdVl0b1lGWkJmVnVPdmJZUkx1RzlpOGF3UDl5bDR6Y3Q3SW5tTHEzUXM1?=
 =?utf-8?B?YmlPM1puSnQ3QnhEUlQ5SXZJMXJaU0U4NXRsYlhDRCtmeGRHdkx3LzA5Nzh2?=
 =?utf-8?B?cThGdEIwYnZXN1ljQ1VkeVVYVVM1cENWa0Y0RWZSdVM3R0JJT0dleWxlQmJn?=
 =?utf-8?B?eE5MS3BiZmpkaGVzWEhXQUxacGh1cXpUNzJRWmlXVkkvTFpjNWg2VE9HQ21W?=
 =?utf-8?B?TUZUYURkR2Y0TVpkWFJubklob1FOdVVrTFN6MTJNbUVKMUt1dFZ1dlhOQnhx?=
 =?utf-8?B?Z0xlOTdXVTJsamgxT2lyMGREdVNrVUk1WnZ5ZjNSTXJtQTgxcjA1cHlMSmdS?=
 =?utf-8?B?NXlTbHdvRmMrbnZiYUpYNHZ6L1BMU09CSVlrZ1c5Rko4Ny9DL2U4SXpXcTM1?=
 =?utf-8?B?R3pLeXZzNVFpWkpTOFUyb3J2eGxxakM1L09QTDduRDlOcHR5bVRvOFlodTVU?=
 =?utf-8?B?WkhTeHFPVURYT2FyaldKcDdBdkNCOVRXdFFhQUhySndISVRlUjZSWWZmb3c3?=
 =?utf-8?B?OGRUMGdCbldrcnBCclBIRXBWSlIzaGYvNngyV2pqTU85bUhESG81K2tCK0tB?=
 =?utf-8?B?ajgxamtxUnFNazJsUHNoU2hWUVhjMHY0U3l4enBjUlJKeUg0VWdNcWxQd2I5?=
 =?utf-8?B?WGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d4d71c-e3db-4cdc-4a5a-08dd6d0d3c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 08:56:16.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIZNSsjWSzVHozXzbTwxFoGugv6UUBQsuXbG0FWHAInb5OdpZeS4P4pRAu9UxJZ17772PeZ2vbvJSvvy/XlGJoa6M+dXbYhSp+hGojUv8hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6607

SGkgbGlzdCENCg0KSSdtIG5vdCBzdXJlIGlmIHRoZSBrZXJuZWwgYnVnIHRyYWNrZXIgaXMgdXNl
ZCBmb3IgdHJhY2tpbmcgdGhlIFJULXJlbGF0ZWQgaXNzdWVzLCBzbyBJIHRob3VnaHQgSSB3b3Vs
ZCBhbHNvIHNlbmQgYSBtZXNzYWdlIGhlcmUuIFRoaXMgaXMgcmVnYXJkaW5nIHRoZXNlIHR3byBp
c3N1ZXM6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE5OTE5
IGFuZCBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxOTkyMC4g
QnJpZWZseSwgb24gYSBIUEUgREwxMTAgR2VuMTEgc3lzdGVtIHJ1bm5pbmcgNi4xMi4xMyBrZXJu
ZWwgKFRhbG9zIExpbnV4KSwgSSBzZWUgZGFpbHkgY3Jhc2hlcyB3aGljaCBzZWVtIHRvIGJlIHJl
bGF0ZWQgdG8gdGhlIFBSRUVNUFRfUlQga2VybmVsLg0KDQpUaGUgZmlyc3QgaXNzdWUgc2VlbXMg
dG8gYmUgdHJpZ2dlcmluZyBhbiBhc3NlcnQgb24gbGluZSBrZXJuZWwvc2NoZWQvcnQuYzoxMDM1
IC4gQmFzZWQgb24gbXkgdW5kZXJzdGFuZGluZywgdGhlIG5yX3JxLT5ydF9ydW5uaW5nIHZhbHVl
IGRyb3BzIHRvIDAsIHdoaWNoIHNob3VsZCBub3QgYmUgcG9zc2libGUuIFRoZSBzZWNvbmQgaXNz
dWUgcmVsYXRlcyB0byAibm90LXByZXNlbnQgcGFnZSIgaXNzdWUuIEknbSBndWVzc2luZyBpdCBt
aWdodCBiZSByZWxhdGVkIHRvIFJUIGJlY2F1c2UgSSBkb24ndCBzZWUgaXQgd2l0aCBub24tUlQg
a2VybmVsLCBhbmQgcnQgc3BpbiBsb2NrIHNlZW1zIHRvIGJlIHBhcnQgb2YgdGhlIGJhY2t0cmFj
ZS4gVGhlIGNyYXNoIG9jY3VycyB3aXRoIHZhcmlvdXMgYmFja3RyYWNlcyBidXQgc2VlbXMgdG8g
cmVsYXRlIHRvIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDA1MSBlYWNoIHRpbWUgaXQgaGFwcGVucy4g
VGhlIHN5c3RlbSBoYXMgYSBNZWxsYW5veCBhbmQgYW4gSW50ZWwgTklDIHVzaW5nIG1seDUgYW5k
IGljZSBkcml2ZXJzLg0KDQpBbnkgaGVscCBvciBkZWJ1Z2dpbmcgdGlwcyB3b3VsZCBiZSBhcHBy
ZWNpYXRlZCEgVGhhbmtzIQ0KDQpJc21vDQo=

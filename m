Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442464;
	b=BYKNC17U76wH4TSJXxEeMKcjCmU4sK7vMnQi63jxDjcOTw4hAF+31I2uTSc15kxxDbZ8
	 UUOB6Av414NqDXPMphb5cBybwXKDB+omJpDQ8EZQsTbywfSfkPZ3d+fEoP4tFZiaACtEN
	 ZIl6OcaS726jEg37Th1j7bvuABZtZ2bDt/0W4q7K/Z79YMy3ZXdDtlmTtKiVAAhwPTgh9
	 cayIgr/M/6rfDWXTO1m5RrzNwYVFRn/2JVJW0YP07IHO/W2oESGbi22H44lt/fLgV7quI
	 J+kG+B8TWZhmP5tykHh3fy3uY4RtfQhY7IjQJpiWr8/VLPII03RdsOfBS0uAEtFa15Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442464;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8M7XTgAAE1u1DJ5ffQrQDnN35l1SCRKBaXoZibPKztE=;
	b=1oxyNVU8B91hVApYwn77SITg5BLeNVLAiGpKDGZ6XPTxp9zhphT18+thFoOeEg67rxE5
	 Bku40DAxLI3JweOuhwg41G49ugfMUMbYffR1IjJ4NMqBP5pgchfyY3iwmCLa9hfGfpgR6
	 9SDhZj7hrc+fumG/wBsOqc+0LRkTqE+nEGNQeg1i5wBm+rQOcoRuO5PM8S5q78AXI/7Gu
	 kMh9MtS3y8xwqKGOS/2tC7oIUpdo12GKy93wjAswhj+yXRdAAwCuZt6PdXJftiWpcGdTQ
	 JBxsIeGREs9Cyg8ArLR31bRtf7xS3LYYue0xA+C7bXhOasnbz4kmMAy7P5GnMonrF/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=aIQsfE6B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.125
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022125.outbound.protection.outlook.com [40.107.193.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA824606A31F;
	Mon, 23 Nov 2026 14:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA824606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=aIQsfE6B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asmDDSRnTjWeycathiE2d0a16K69MzqkAXgKTfazdH4QRiBD/QbuTaZw96r4YQs7ySmCLzafYRXmJ/JHXsY0kfapJtsAZ9n9/OnOv0+v18i00IaRNMll+2Aht7cXIzi9BG+QIwnjXv1oiudXVwqOJmNKU1Nn2TVofvPzuNFEP/I8diprlLJNpMOmCMeIM13RsYBvSDQdvtIx+BqzFCu6qJuW/sVcDAG0TMSdSIALT7UZQxKLE0lAhJ7coEt2qQDZuljAwOAjTJSqYOZn6mP5zMWKS4bsYRABi5vcfDWZqE8CzH1y8yjJ7VDLP8+8mj8WqVg+LilaQ9akkiv65UU0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8M7XTgAAE1u1DJ5ffQrQDnN35l1SCRKBaXoZibPKztE=;
 b=o/2x1mWKuRVFt+eqvHpODhoxkxUNtrf0HTa2aREduQevSLA1VDYfITVu25iRcoBKmzBb2C2Ky9R8I0Br3Go0GgdiUR9nhEpzu8pCNZ39A70yGoNZJyl4kgiA1pwQiJANbvmPjcO6+nG7QC4mO1RZicedpslhDodysB5TJRpIkAI/cGAOS1eD+XcgJ5OxK13jA8STItLJ77h0PjD/s2To4a+tEkRLGt19XGcDLvOtD5xKPsCwLcEnVHfqo4KocRE2R9VcLoOzw4tOdhXb/69ZYc/p5jcRAROEgz1dih/ngfCskkHXwGfjMiHyX0xuucHUjbKqG2X/mxvJL/LaICjKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M7XTgAAE1u1DJ5ffQrQDnN35l1SCRKBaXoZibPKztE=;
 b=aIQsfE6BR4kbbtemTsKw9UILK+GBS0+J/scAxMA4MpK60ZQFFHr3uSJRMUrO0XW8C7MI7nsRskRkR+4GFbfjekNJUQvJ9/lq9ygWx4cJ+HtpJVk+2gUiPBr8CwlxaWtpKbgyOYOliJo3QKH8xPMA483RVDle8aG01nb1HjUsJbGCcnyZcZbbBEd98t55znN4VN2crnpDZSLPnWTr3cyzkAPKZFLbcxyI7N+HACq1jHUOi9Ik2hV+AEaCTTMWBPCQ+lbJsMlRJ2W3hFysYjV9Xhd+sDdUUX7sMNu4s9iI+DYZ/OX8jn/6p2PNIQ3tYQPPapdNjxX9Y98lFAH28R+N1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB452843.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:18::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 14:01:02 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 14:01:02 +0000
Message-ID: <109fd5f5-a48c-4478-b29f-b6bf9017121d@efficios.com>
Date: Mon, 23 Nov 2026 09:01:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 31/40] selftests/sched: Test deadline boosts in
 deadline_bw_test
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <e0d14db39ed097c54761a08cb3a1c3e5a57f81ea.1795207233.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226131@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226131@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::19) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB452843:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b597761-898d-483e-b3ec-08df496a3560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	T+li7/nkyOIIY1+cF5p6SPZ887Yfcxq9fbAw1GCoMwO65mDTNN8/IVTVpyhxGMv2LF46lhm0xpK9d6JeEwh6lFIUPWwOlGTTUYdnn2gMCQpZ6hV+nztLA1fYXKwckmHZ73+k2AqmiSsB0p7ZXAHA6HiaBjy5LvaM04/ogutvdBZBKC7QPKgHvE3/hJKqoyiAczNbEYxjnyiNJhC7YY0KyDF7uc1mDHl19yTnCYOEqtnxhi4yUb3eBvXyCoxzW3Zkq8bWJg/rAdANyJZQ+Xf3S0qRKNTOWOLHkasPKulgvvgWIouCcJ3+JclP4eEQQ6bcUR1u+4c5zhIeTyIG7eBZFcyFaKOEtRQn2bDwfg5fsGzV2cOxjcsvlJ1hhbJJvLnMUlOUPsOkS+gDHFDsF4Vi3aQqtv1oPZbvcj8t9E9DJxfFzn677Ely7Zbb/23qUkqRpflD6a6BIei5IzmPfWTJIP67JUTZ/QSpT+v8CdUqoT4kJG1hlOUhd1+Yz/gOU1oqy4KPm1ob4vambjyUTXIIk2IavLp4WMSBz0YD14bQgNlO5BnT21PP6Hwvu1bD1BnSCN6MJRr5F3i0VyERs6FKFdbeonZrLGl85Pjnvt5DOdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjE2Um1YQkJJUHpUS2dMNjdRa0hudEhoVTFVeXJoekY5d0EyMXp6NWZpaE1Y?=
 =?utf-8?B?b1diTDY2TEZnaStVZklKaXI3amw1RUcrRkloclZHazJxd1Z4Q1I0NHk1R05o?=
 =?utf-8?B?ZXNSdmMxY1lQdGphYU5XRHZRTy9wTzU5YUl4cW0wOEx1b0U3cnJySmNBeW1N?=
 =?utf-8?B?cU1FMkcybHhzc015aVNXUHpob0NDbGwvQVhwOHVyOXFDTW9objk5VU9aWlRQ?=
 =?utf-8?B?VXpLdkVqcFdzbWVXaFhpTzByTlVzcE9nY09hMUdWcHZiR3hYY01QUGhJNWd0?=
 =?utf-8?B?T1NKL2wrZU4xNkYzeVFWczFTdDhuSVZ1bTM2bE05TnRxclMyRmVtK2xjbzh6?=
 =?utf-8?B?UEhhamc3dENpSHR5ajNrRnJaTDNmMHp4TFdvQkdhRWNnczFCaWtFbFFaTHJ4?=
 =?utf-8?B?R2V1bFRTaWRmdVBvSlJTYkhGNS9PYklHTjloU0NoT1RSSlpvVGxrSEhneXBG?=
 =?utf-8?B?SC9hY2NsMFIrUUhXOU9kcXVidDluelppbmxDRDlMSVF4eDQ4UmVxTkhna3VV?=
 =?utf-8?B?U1M5NVFxcmJjVXBwdVBldzhtcTQxcGN2WHFkbEgyaDg4cmxDV21sTTJaZnVn?=
 =?utf-8?B?Q3R2WjNjcXdCVU5Ub1p1Zk5nNFdIMXVMTHJEelhYNU5HUzRBK1AydEtaN3lV?=
 =?utf-8?B?MmJFOG5HdU1LZ3RZbG1NeHNVY0dQZ3dyRGlyTS95TkZNWTU0V29PSG9WMWZT?=
 =?utf-8?B?SnhHbk0yaGwycFlGT2dTUm9MekdoVGpsWklRRVlvS1FNaXdwMy90dEZkaE5q?=
 =?utf-8?B?Y0ZSUWRYc2FLcDlMeFEvYStYZzU3ZUhxamRpaSt2THRObEJoOVVYc1REaGMy?=
 =?utf-8?B?anM5bFRqd25QVUdtNzMzUkl0cWNYbWtJZStKanNBellub1RJRml5YU1ETSs0?=
 =?utf-8?B?MlZjTVYyQVlqamh4U3QwaGZJRTRvdDFJNGpTUHdpaUl4LytJZHpsQ1Q2d0hz?=
 =?utf-8?B?elpOSTN4YnJxN2lwYXk2aHZlTGhZN3RaU3Q1eUhoblUzeGdHbWtoNUZ1Kzc3?=
 =?utf-8?B?YkczQkxFWDJBcnBWZG9MTHNHRmtseDZQdG82bWNBYTREblh2dGZrTFNub3VN?=
 =?utf-8?B?MlpRZU1WeFZZNHphT0sycUoyLzErMG5BZFhHcnA3ZnRVTFhGUnF5ZThxZjVP?=
 =?utf-8?B?S3h4NjV3ZGJEUGlhSUNUMXV0R1VPaGNzRHdXN3FnVlZuY1V5aHVCeVBGRkxW?=
 =?utf-8?B?dGNvNFBISi8zejlxQkFIN2RlUit0ekg4SUxBa3BqczVOZ0tsdmlOak90cWZV?=
 =?utf-8?B?T1lvb1Bjc1YrTDZhSWJudERCL3ZpWjllQnZDaEFTVXRPL3dCZFVsRS9NM0pG?=
 =?utf-8?B?ZEhsdEJnd0Q4YjRaTVNxaUcwSzdkNG1KWWVWdWZBT3VZUkhQd0FNWGlTNUNW?=
 =?utf-8?B?TjNQUFRlVjU3T1VleCttY3VuTjh3cXA3eTI1amg2cmxQSU92bzNXRzQ1Ylpr?=
 =?utf-8?B?cGdCblBaSWMrS1BxY2NHMkNBZGtRaytSVnQ1WXUwSjJNeVdycXhXSmFWYkdJ?=
 =?utf-8?B?bUhZdWd1TEl0eVBLYy8yR1Vyc09WaGVBNFJzNnJWbVFHY25sSVJYQzFEU2ZS?=
 =?utf-8?B?SmVQMjRVcWFDRUhsUkRxUzZoMjJzb3VoVjZXOVE0SWhCRzMrc0ljTGxWVDF5?=
 =?utf-8?B?UDV4SEpvZEk0RmNUbnVoQ0NTWTkzWkRuWkhxbjNlWmNDSUlHU25RbkVOSmgv?=
 =?utf-8?B?YllZT2oyMFlZUFlLV2k3MkFGSlcyamc2eTF1Z3Z1QVV4azh0Mk5KL0ZmVVdt?=
 =?utf-8?B?T3FtWm5WVzJSWThTNzc1aURqMTFxby9ITzEwSDIyMW5rdzJhV3NOMkhSYWZk?=
 =?utf-8?B?Rkt0aGUwUCs4RmtNcUw3UlV2OW93b1pIWDNlN3Y4K1paT1pOb0FMRzlaTW95?=
 =?utf-8?B?bHZVU0xkS0lYUFE3bitHbXp0aGFnRTliTTZBSWlWOFcwK25ZbVk3UXlIVlFo?=
 =?utf-8?B?ZG1qUDJtZkJndWd6ZllsRnB5VGowR1pkUEFEZFRPQXVvVDY2dkduNDB4SElQ?=
 =?utf-8?B?VHVLejlsNGtUTTV0UE9PVEdRUXlCeGpCa25ZOTBrbFRPRi9WVWV1U3g4T2NV?=
 =?utf-8?B?c2lIUnNuNloyRGRZWW9ldmd0OWxabXcxdWs0dHVVUi9UMGk0S2NwKzhmNVA2?=
 =?utf-8?B?aWM5WWp5M2dNM3ZhSUZqRldzeTBMVVh3RnNMazY4T1dVMzdVb0VtZkY2SVFC?=
 =?utf-8?B?ZXM1TFhnSENId0s5VzhSeWwxTHNMcEdnT1VtY3U2K1N2d21tQ2hSVC90RDJx?=
 =?utf-8?B?dTUxSG5pYzBNWE5LTSt3OXU5bHk4dWE0d1BVZ2hjb0N4ZHAvU0dmR21SbzBM?=
 =?utf-8?B?QVdTeEJlTk9GMHlqc1hHS1VkQjI4Q2pPN1lVV2kzS0Vham1vNlhGRFdyS3Rw?=
 =?utf-8?Q?Dv2EK2nfGMeuXt5lr0PJNPclXI8Jr2cL1goQ1?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b597761-898d-483e-b3ec-08df496a3560
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:01:02.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmD+DQFqQC0Y01x0wBj5iOOW8VIHoEv65ZOexZhJUieAf8cBIfAbnBut0jDkqu+29zjXDCjgD5/eBrHFLJgtzXTfX8ER54Jyma0MTVELB+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB452843

> Will join(d) hang on these two error paths if aslp_read_done is not
> posted?

Yes. v11 will post aslp_read_done on both paths.

> Does FUTEX_WAKE wake W when it is sleeping in FUTEX_WAIT_REQUEUE_PI on
> rq_cond?

No. In v11, the error path will wake W with FUTEX_CMP_REQUEUE_PI, which
gives it rq_pi. It will then set rq_cond, in case W has not started its
wait.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

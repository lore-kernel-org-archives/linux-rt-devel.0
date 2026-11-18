Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795008866;
	b=1tulER9zedbmL8K7VfBMGYGCE44ogXQU0ssg8lpVlw9ykQjcovKxwBle/5dZl4PA+Kn7
	 7UiTGB+8o4rSrmpO5LBdjvVKg2EH7IvoAl2fVSRrq1d++zH98LA3wko3jPnsBkbbH7lJZ
	 aviz7OdBdmqQrX9u8Lw7zIFmo3YbmleHuOSepQBMUnT7Eyqki+bF9J5bv6h9iv8k59D9u
	 8O+M2PfMXgNTSuvL/SclWfS1kpHQz8Ma5gDLjKEcuq+pfoldFz82tc14mQxtRqcMkkpbt
	 zRNfq5zKkyAZKnoxhnZCgxl12OL+NHy5JVehttv5iQ/HjU4oK9KO5rCHRY+2bgZBZMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008866;
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
	bh=32nivxkDO4Bk7vRTYZktuUiyAGOoWQQMXr0L2kS6HbM=;
	b=Md6TotVFPFq35hQSSyUoLEtAXp8EKgMuZ74FRbvMzYv2S+85iCcgLb4aqkvENBzuVdpw
	 JWQrPNirhV0l4SF2EQGz9GVqx8acFrUKDrM12m//ppXzUjr5TlZC5K1KXd3fU/GKCKvtA
	 7lERoV0eDBK/mD3I4Vk4/qQIp7WjbaRxtsrj2UD1W+5lJjdBfgh4OcZjNFwzOxAg9INNZ
	 IiossGxjwGk0xv1707E7Avx2zCYItTGfjYVydvc0CzCudGavGozz03x/0kjjWFPjIBjma
	 Ns6dmCpiooqY26xLKtSrGmAlJwlu6E4f1eDFUrebVuvUUhztewKTOdP8J3/2o/Gm5PQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Bc1TcI9E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.102
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020102.outbound.protection.outlook.com [52.101.189.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5A606A31C;
	Wed, 18 Nov 2026 13:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6B5A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Bc1TcI9E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI9foomroolkhDiLj4q4XlXPpWmNHNKjh78U3VPYjNLNLqaMO8yDDF4T3mDwawRSiAwUztSYN8sMhgfACE5W9f3DPBSlhI2nogYEC4SvB8sEVaSYKrV5DEzNYG4aOw+R3BnIvVXklVrINySiIkvgrNqAh52EYGPAgPdM3kqlxsEqsJKY5F5I20Q+4kJ9ShUZDbqybon3rPOfpgdXOSIUJ5qcyYvU3qLBqmstKsG5EmRz0ILGnqlNGgS98R6BIAcPuSpdSyIIup4O4gweoJcfO+Q9zv5EHVV3JsuTOnqBQpPUYAeNbAUh/E3MZ0abFk0+lBLZQT+hfmq7ztNowEzw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32nivxkDO4Bk7vRTYZktuUiyAGOoWQQMXr0L2kS6HbM=;
 b=LMMg91IvgOUmDVsjMU1egu0Jg4NKCQ008QJ7czfbQ4Us1gQ72dHSSiYzXoI51ch0EQzUZcD3cGvKFa5haY1DH+0JLNp/LL68LYPGkGO5erZGjITpRQqdNAtgGVwMXAieKJ6FNhu9lmsuqx6AXHeC5qVS045cnkQeGjplp2Q1LixFgAGhlgiWU/XW17mcTr+YADQzzgspZbmam0vYBCjgw9Qo9QxSOBJooLSajjCGntlq2+mb6c+pJ62IyxlrM6x+nEHnowX3IReFDQC05tW8hrXN4kdBDowBkBdGYXTwGmxqxPoHY51wdhtoqc1/CCdH+XarTiv0o9iDFDq6/7xsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32nivxkDO4Bk7vRTYZktuUiyAGOoWQQMXr0L2kS6HbM=;
 b=Bc1TcI9Eez86WsBANQRVCRvM05FmmcjX+d+A7cocHux6Hm6okfdf0zzwvdkhdGZ7D/fHzPZfOyrLALgjZQmaaeXn+RDfrA1MLFpXn746j2uMQgWSqTPDwoKYSFmiTWCpy+E1NHhFHWKgD85A741XsSTe1/YKPKwtuubR9Ba37TE9J5ueO88a90SR4GgxZSgM0vMMpyt42NIJGHs+dbQAcfqeBWAT3unuiCOInBTo5t3r0/7Pz93GhdfTy+YRrBVcyE6SvxPNRn8AIdz6WcqMudPgvAvSRkIBqY5G0z7L4JoYYENHxcVC7qKFZ1NdYztmjyUIzJwOdKhzz9I+tHfjYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB9677.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:80::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:34:20 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:34:20 +0000
Message-ID: <8c6b106a-ba71-4614-b464-f42de3b43ae2@efficios.com>
Date: Wed, 18 Nov 2026 08:34:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/40] sched/deadline: Reset the deadline and the
 runtime with the parameters
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <2931e871568442196444a57d784b64c04f57f968.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219003@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-219003@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQBPR0101MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8d305b-8b3b-4756-4773-08df4578a682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|5023799004|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	iKka8W5gHGdqK4tixfNHZhO2DRes0iQlgke0iumif4dMLy6fN9S8qf1lBK9L2SoneOzn8HqsV0P8P/uY7e1lkUjoHMVNLi09/BJdMFiV9xOmTmjS6ayCDy0gvfdiy7RffbsYlJbeLGAJXjviYZ4fHtjE14UjvuthJrRPpKvrV6IQ4WfUbtzD2kGiyQH7+6QeR8v5AR9BeHTr8F/7baer46wU7Di1AvYmFTbvvpktMRKAOhMiV9dDZIr1tHxh6eSB9ia14LLiBmOaNrD0+eFjS4KeJTgV2okDUFAryl0kKHR0dHJjkVfi3ip8LmeDguPjJ0M389U7eGGjxCSCm3gxz5vw55BpfBZFg2qLK+7soqGUae8B6bXDuyUpNK345Qiu3Hi6WXdLAULPEHECLlTAgxVdQ258NTs7/7WP2f6odLO/q7U2L86oKgLmjC8UGtRb1/bE+HHU06B1fb2H7kcoAYHxk6nxoGYEnpNlfbw5j6bR8Sdd7zonZIdu441qrjfg3SzTK/Oc9zQeLTy6/BBVCMYTtYxa3/NKHyvY/QGxkgGWNj6flxOIv6zfNEKrRfOg4g3VINtTTNWU2aN5Um5wxXnn28v+eEBX8VTA93cDhUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(5023799004)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUwxMDUzTjNDajVwTFVwTmdhSWxCZ3pCdXpGdkdUb05rdGowWWkrbi9TYXlZ?=
 =?utf-8?B?N3paSmV2ck9sck5rNWNUN3BDNC95b2xDQmYvb3JjRWl2UHJPdytua1VGdEla?=
 =?utf-8?B?Ty9uUURRUmU5Nm40ekhrYytZSGVRbWhLRkxtMmNoZmoxYjFpVG9GSHY5K0k5?=
 =?utf-8?B?RS9IQkhVQkNUV1RjVERiQ1VBMU1qNk9MWFV5SWRHZmE3S21uTDE0M3pvU0tq?=
 =?utf-8?B?TGFmYlZTK3ZpcENmUjJad1poVVRLbHNDRnB1QUFDQ3BjOC9yajd2WjVsUUVM?=
 =?utf-8?B?T3NRTGxvWEJlYkRkdTNxNXg2M2dkaSswVUJSWnpEOTY3cWRlZWtQb1ZCNVVS?=
 =?utf-8?B?a2dyS3dIS1h6WjVqVGs1WXljREJncFVkVVZZbVZCM3gxWGs4NGVPUUlGMUhk?=
 =?utf-8?B?NzZDaWtwZWhHNmdmTDg4emt5ZE80MmhaaUNRa1V5Q3lzN1E2cEtQU3BSM3o0?=
 =?utf-8?B?Z0V2VVU1YWpDVjlQM3llajBydUFhMktIeHpPZG5OMVh5emtxL2U0SytNZm5t?=
 =?utf-8?B?ZmE3dFNBUUM2K2ZiaUM1TGIwejNFWlFCa0xGOUxnSFJWYkhDY21MSkNBRXB6?=
 =?utf-8?B?VmFSamx1WmlxcjA5NXF5djY3MEZCeVpPQmZObWNpS3hCK1d3Q0lOdzFRN3hr?=
 =?utf-8?B?SFBuZWhBc05MYkdDOHlvRGNEQ2d2bzQ4S1dvc292ejlwbzV4WXZtNVFQZmx6?=
 =?utf-8?B?Qk93RjkvTHBjZVpZdmQzZ0Qza2NydlNxTkdNMXVkN0hISkI1QTcyWDQzeVJi?=
 =?utf-8?B?aVpGVmpaNFFOQkRicG5FVHplbnkrSTAyNjg2V015djJnL0JKSFRqYXlPUlJT?=
 =?utf-8?B?SHhncHNHWUttcDdtWitJcDc4dmpnZXROYkNJamF4NkRFa3cwMnVFNTZVWFBu?=
 =?utf-8?B?UUUvNTltL2FabzVYdWlHTzZ4cXpjL3RxcXNKdUZkUk44WWl6d3BibUozMGVD?=
 =?utf-8?B?eHltL2thMlpVMEFaa092alVSRXdOZ0hseDhwZmpJM0NFVXlxZWNPa0NaRmFX?=
 =?utf-8?B?SnJDbGZmbGE0QmQvQ0xrL1ZqZGZKNXVHaEg3SDdGMWVTTEtDQU56bDFrcDgy?=
 =?utf-8?B?ZEtlZHd0L20xZnRSRFJZcE9LZ0k0bWFpTkJjalJ4WGdZYnpaWmg2YVFEd3RN?=
 =?utf-8?B?b0FTQmZIekRQNUdxbytaUzFIM0pIaTlNMmJyd0RJRFhzeityeDdDL3ZaeG5t?=
 =?utf-8?B?YnFqZnAzNjBNQ01kOUlJM21wUVo2SWFNbWQ4aDJTK3F4bHNTWFpsUXFuc0lV?=
 =?utf-8?B?WXZNemIrbEVZdVl2UGVDMnNJMHl6YlMwS3B0Y2lIRDZSbEtKWFkrQmo4bnZy?=
 =?utf-8?B?Q3NzS1JON2tzVE9md1JyZVBnU2d3bW9HR253YlhqQjJTREhMeUhvRWwzdzRH?=
 =?utf-8?B?NkJRdlNkSUxTdWpHcXRkRlA4VDJiK1BCcnV4UEkwZ0h4TXZRcVVtUmE2Tk52?=
 =?utf-8?B?cVM3UmlGOHBOZ2U0VHRPTWFUczlyN2JBNGp0eUI2WUxXb1plMHVTQUY4QU9W?=
 =?utf-8?B?ZGxHRy9ubTRLSVRpWDlMbGUvNEdUQ3o4bWI2aysxK1Roc3JFMzlRenMxQ0Zl?=
 =?utf-8?B?ZElSWlcxSi9iNjkvYzZnRFJSWElBaFgwRGtCUkRDdXlISEdwc2s0NG1zdnl3?=
 =?utf-8?B?RXFpT2VVNHp4ZFAxOWNNT1RIMk4wMzRRWWFFWFMyYmw0cVIrSlNIQ3VwMHRL?=
 =?utf-8?B?YlM0Z1kzeXBNK3B4a1dLUGZXRVZiUDdkRTZmL1lITmlQQUdaSzI2WlFFdmp0?=
 =?utf-8?B?VUlQMmhjeVpoSGZzQkZXVzRMbkVhOFlLM3JxK1dXNUFYYlcyM2l3eW41MS9m?=
 =?utf-8?B?MzRwNVdLYldyTmRudGlNWC9rZm1SMWFIWHNwaGZsVWtCNndiMW53NzA4STBu?=
 =?utf-8?B?YWE0Y2RQM3pkbDNzN2FkR0dxUERUbVMxSlVRUmhmTDU5VHZCYlIraHk0RXN6?=
 =?utf-8?B?TGcwNmt6RXk4Slc5TzQ4QkNTMFFrVjQ4dGpNeXlJL3ZGZ0VkYnBxazNiREN1?=
 =?utf-8?B?R25MeERPT0NHMkI1OU0wdUR2MmJUcHhBTk1MdUMrWGJsWWthbkFQM2dpTUhM?=
 =?utf-8?B?alk3LzdWc3hyUFdTbWdobXpzQ0FCYm1mVmhsSC9sT01NWk90L2wvOHZIZkJt?=
 =?utf-8?B?Z3JyTGR3YmNuazNMcENzckswdnVEN2xVTS9yaENNc2V4R3JEcEcyN2hEMEIx?=
 =?utf-8?B?djByZ2k0NU9ZZExQNlZzekFGcFdjUncyZTk0em1kN05xeUNVWVhYNkh2STJM?=
 =?utf-8?B?ZjhUcXFleHRVOXQ1eEJUbU1QRUpWQW9WNzNCYlJRYkIvTzROWERXdGVXREcx?=
 =?utf-8?B?MCswVWdsNHJuYU1HYzlmRHI4K1ZOTXNLQ09FTEM3djZ6Q1Y4RSt6M2U1OGZx?=
 =?utf-8?Q?2jzhw3i4jXuPiF1qnk17vgb8gGOd0pGekbFGI?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8d305b-8b3b-4756-4773-08df4578a682
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:34:20.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFMImWdawUmzYRYlC05ZPkcZYtfVaBKtvWJIqex62O7rY6BE2Yjb9Ff+it1lZaRSfuokxeEFYucMiTgLIWVE6xCRj/+NKA7WXXvlfyNs28A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9677

> Can a task deboosting via switched_from_dl() still retain a donor's
> deadline and runtime when p->dl.dl_runtime is non-zero?

Yes, and upstream does the same. This is known. The v7 cover letter
lists it under "Not changed". At a deboost, the 0-lag time of a task
comes from the deadline and runtime of the boost.

It cannot be fixed without the deadline and runtime the task had before
the boost. Nothing stores them. A new period of its own at that point
gives a 0-lag time of about now. That releases the bandwidth at once.

> otherwise, p keeps the donor's runtime and can consume it on top of
> its own reservation if it re-enters SCHED_DEADLINE before the
> inactive timer fires.

That return is checked. Patches 35 and 36 check the runtime left against
the task's own parameters, as a wakeup does. A runtime that does not fit
starts a new period.

The cover letter of the next version states this point more clearly
under "Not changed". All of this was checked by reading.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009168;
	b=lyjhkLvxVZQFXBSln7CAKi1Rsr9Ea/3rHO+dEivCb4DUneHQ42cZgF+h4+2wYwmAiT85
	 jeh9Tg16juSHOd54i4t7ya7wLW5to+BdZAd/j6TeF7s0Ph87TrsEZ5Gn6sR3YsfcNWuTc
	 PluMgTYRyT69256A3Q5jgWYPcTD4hbn71jHdmR93D6j2B4ryLnN9BfWvIXv0RZoZdVe+Q
	 rNbZJKvTVmfD9D3TT6Kn1ou6oaTFqxzv/uBPPAvhYyqH6vhiGFEqEmIA9Xuyb9Bf64Z3G
	 6Jm0R5wHYqJ0hk9FY45dpGSqTqtCCU/x0ntdB/vEsQUxuhqrhbAFxi1ytOCaE0t8a/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009168;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=p2WnK3lhlJZo1qamgl71f8A1iqUbHuKOgEtr1nZH/3k=;
	b=YkrhFV2fY9GZF/dGpAzNiIIdQDK4AxqbMDuPW+68tWXyVNbSf7aBf0MRxPso4u+l935s
	 0n8N4NwDnw3x3SkHpdmvwZacsY9JWUZeQiyUhLnQ1x8Lsd8OSA6yTiZTBa/F2vj8WXsGH
	 q0FemIcRXcaiyVdTSbCYObRUEKoxF0DjZtJrDoGgNFAr/cOJ+u/eVZCXa6rCqHXMiW8QI
	 tL4FujvhXRq0xGKgIMQA82c8oekJKmCV6yMjZxUWNIqo1Cg012dSxWCRWPrTSxlgCtPJ2
	 BD+I4BPNDaDoixL9ATK/WdpdtKjf3H51xdGHNIJ5OLOacfnH3vU/gFWOIcw5iI43qUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=pwFjCVFE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.131
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020131.outbound.protection.outlook.com [52.101.189.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0560A2633;
	Wed, 18 Nov 2026 13:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC0560A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=pwFjCVFE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuIKSs5tWHQumjKwegp533GElmr+bzDdLkhhFpShtYdB5/R5g2wfujUMWQyAj4eOjwhJDCJ9jYURID0u+DMNl9c3AcFJBoYii9MWvo2swBTCDuPSvU5RnzJKmJpx9GTWg/I2N7t2mn2NSEOePLt6ua7PDy2NY5wfjNTRq33Xa7f4P+g8ImLq1wBjy3sVL6OuTEvRGht/4vbOuPuRuTpnsU8DoFWNwMjsCMR34pl8CKXhnzTK1GrkounqVARbDFnS9e5vbReHqaLn82WGoMKvexVD2DAklPOjgvLSGbLl7wOs6sZa/5e+DpBVo6+acxVrwyao7ffv9BxioiTZywDI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2WnK3lhlJZo1qamgl71f8A1iqUbHuKOgEtr1nZH/3k=;
 b=A7/NMI9OayK5Zt1n5yuPtrnsgrETZ1CWM9JLPeGGpaoxODtLXBSbXsbjyulhrQ9eNCulK7hG4YtObl1b/WPV46VNrNXpk8kZ0D7auX48HYJSmMN34oWDyGoaYjmcwu22FvvqCu7ecgUofIUjVySd517/y5CRU1ZyloYg8kqTgAKTCbwe+/81SoD5khMtDqBnOrnIR14dn7BNE+4eUXhMTImp3Nx5usCv7O5zDNKa5UXB14plVRo2FbNZjyHnCjpFVD1RuPOLMOVXW2mAJeecqergdnzD1EFSr3u8ECn6RaBRl7cY2xy692rAjig3PRjQ6/51G0+pgtKC0lfVyzo9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2WnK3lhlJZo1qamgl71f8A1iqUbHuKOgEtr1nZH/3k=;
 b=pwFjCVFEGSabKEj3a+zWtTUU2nN+tY8yjbA2LH5Gh964Q/QYlhr6bxZSHSjZvDEBSVGS2cKB28GUSjmFUWjp/svKJfGuccpukVz0dKXNw+ICUPD9ug9gCWxb69b1W3LuG2KbxgbpmnO6by7RwcGGjzbyFhcxgeXHntMNPag6HiSQGU5lWSP7EgyCdF3Ar4BOvylMB0P4t7dMXFSYAzLKwaxvqXHNw5jBui6hrG43RGs13mYAGBpAWOoTXzTDTcCXISCuAW/5CqPpvQn2WSAEs5KtGTPxidDmpw5he8TbsFy7zer5S91gMIEtVGnP1Mohb6jNaTi/RfpEG27G1yCWnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT4PR01MB842743.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:188::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:39:26 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:39:26 +0000
Message-ID: <ee22dfeb-9c99-43aa-8836-e49aa81638b1@efficios.com>
Date: Wed, 18 Nov 2026 08:39:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 26/40] sched/deadline: Make a rebuild count a task in
 the root domain it runs in
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <d956394fd7c5d85d9cd92489b0abf5c709c4545d.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219082@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-219082@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::29) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT4PR01MB842743:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ada090-0ef2-4d0e-f064-08df45795d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|4143699003|56012099006|261026140227099003|261028144727099003|10067099003|261022105027099003|261026121527099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rXfQA8qfiYtkXdqHLDkhcB6IAfPxUHieENt0oNYaC9SagkPxiLZLnte3YmG2AvDfGa3TPFFqEfJ4jm9Ux+fF0oovNoJ1o1pr0D+w5FzXaJD6sZgoge6AFH2ZFx2TawY8jYLeYZBRYkTl/Teox5ibPRNlfXoP3FTqPy/rc4H7ZLmqAlaNTB+G5U/92aSYBTS3Z57UIiSubuz4R7zpZUDC7+pAn2TN3g7JkyRH8p0pu962s7nV8/+3PcjCDDcvwjmOgl0X2jgAc8ndBIJ714Z+l0nWHvw2O4ibKIjISLK3rs0jtMfl5s6l5JrTpvTDq39MoPQc5YhjlrNoq43NH9i1InS50ZZsyAE/MgUfuEqj/aE4K0D8KZoUAj9B9L9d93sZEF1AVbHZLZjSA2moE1CIqk3AAcu8neh8Oo1C9vB9nwMfOwVPkKtiO/J6esysIe5cBP16O9fSzJvp54dkqZ8Kh0mn59pw8OJ3TqESTL0Ubfk0LTYnXNxtmeelkKQXkUvh6KlpchwlWIncvZn8PGXFkoQl2opLo/WTpmT8ZY1OfotlQxByQ5i2dKmRwijuKYiyUHZiuhwX6mI90BW9A2RsiJQgqzBW9zYMVhwpBWQqOSU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sml4QmFGaituSTVIeFA5cS91K1NnamJDa2NqQUJVeGJnTGZyY3kzRGtuYTdN?=
 =?utf-8?B?aTFHZHpISW5vcy9xTnhLNS9jTTBFRjMwSU9NNkFsUGFScG1vQUN3emlSQU9l?=
 =?utf-8?B?WjBwVWFqemh0L3czRlZEOEk3RG8wTytVbkRHN01MZEc2SzFUUndaeGp2QUp5?=
 =?utf-8?B?NUR5TzFJdThLQmF2eXhFdUl4bW1VT0haZ0ZqNmE0V0FNemQvdDAyY25pYU93?=
 =?utf-8?B?NFh1MndEZTc1dzVkYlJBYit4QnQ2N3VBelJKa2JZZnpOazRRWnRzVG9RWkxm?=
 =?utf-8?B?V21OUUVaK3YzWG5iNVVwcXQxZFRxL2poQUFyektDN1ZqOFFHcENaaVJQT1dn?=
 =?utf-8?B?Z3BlRXlXZ0QwRkk0b2JHMnp3aW1mdFdLdGJKa1FmUnlvazNtTjZFTEVnT2Nn?=
 =?utf-8?B?c3NwR2dBR3FpQXhreFdVME1xZkhMMStaZ1hOeHZOZDZXc0FleU14c2ZNcnhn?=
 =?utf-8?B?bVdRN2ZCRnVXQXltSlpGTFR1ZXN4SUxqMHRyZE1nRDJWdVFOQjQzVlY3dHE5?=
 =?utf-8?B?WDBGS3pXckN4TlNJUTRmY0c1MllJVWw0OXNEc25UR2l6VFJrVGNJeDQ3Wnhy?=
 =?utf-8?B?alBJTTZ0YS9zYTFxanR6bUg4a09FNkEwamFwd000UEpkYjdWS1Z6RlQreTRC?=
 =?utf-8?B?R2J6dThqY3gvQWV4MXFrdHJZUnBKUDkxTFRWQ2IwMmdlVHhMdVJYU3lycmdH?=
 =?utf-8?B?aTBqNFVEaHNtK0lHQ2xYY0g3RzZ2TDdvMWt6Q05vL3l3c1JzdjJuSEpmT3lC?=
 =?utf-8?B?TjFyaFIvcWtrTGdHUGF0NWh2Sk1MemRSV2NKVWs0VXBLRHJpdHJnQ0NWRkw4?=
 =?utf-8?B?RE5DY2k4b0JwVmt0TDF4M01WOVJvTDVsMW04aXk5MmJCWVZnc25XQW4rczBl?=
 =?utf-8?B?Wmg5UjV0aVFLUWZIZWFoU1ZPVHJjemZMZUhsSnEwRDlOc2xrNk1wVlFPVHR6?=
 =?utf-8?B?T1Y0TDRzWStKczRYaHJvSXo3ZkZUYytMUDBPR3ZNNkd1d3BjS1pYeWo1NnUx?=
 =?utf-8?B?SlZyTGpGc2NCS2VWWkUySGVkZHhBWFRvbUFaelNraGxMY3R1aDBlNjVrcEI5?=
 =?utf-8?B?VTlnUDlMRXBVRmc2a1BtSjRHbzNyY1RIK3k1Mmtld0NvdkFyOHRBTzRCQXZO?=
 =?utf-8?B?ZzJPM2JVbU5VK0dseHU4Zkp5ZFJtWlZxdHBWQWd2enVUNHZsYm5yYUVRc2c1?=
 =?utf-8?B?VXNJNDBqQmpiY09tQWY2TUFWRFB3REd4Q0Z2QVFCck5HZmo0S3AxNFc4UWF4?=
 =?utf-8?B?VW5EeXo2RXBINk01TXdrcnNPR0NpWDhyUTYxRURZQlBiRytRaVppRHB6V3lz?=
 =?utf-8?B?b2srZk1PZC92cWpZenRReS9iNW9KTlNxUmpuTmJzL2VZZW1lamw0WmUyOEs4?=
 =?utf-8?B?TVg3aExSN2ZVd28zazBOSnEwaTg5Mm5sT0lnam1jVU50ZGEwTThZeXI4SGV3?=
 =?utf-8?B?Qkh3WkVXejA3ZEZCWVRyai9vVG91TVB5RkNZc0ptVnd3U3ZOVmlYalhENmY3?=
 =?utf-8?B?U0lEWG9xNUhpZEgreTRxUmVObFhka042VElRaE9XSnpqNmp3UnFuSkxVMVBq?=
 =?utf-8?B?cTBNSFFNeHFLY1BlTUJWUmtuc25mTDRYVkQzRHpHK3Z0eThXQ2JFRjFvb0VS?=
 =?utf-8?B?NTNxdkxoZVJ3NVFuR1VISWVjL0FuS0NZUkF1eVM4UlNKZVdvcE83OHUvUTIz?=
 =?utf-8?B?WkpyY2FWSWhVU3B3Slh6cVRvRExFZ21tUlY1TG5VaFdBNUpDV29wSllJcXAv?=
 =?utf-8?B?MDBUaUJXaEk4OGpvVkloUU05Y29YZGNwd0xXRFdpRlNzRWNFWkdjRWgybXJP?=
 =?utf-8?B?NXlWTE5ZbzgxQ0RTSnAxTHdYS2gwMmYrb0JBUzNOVzVNRkJZOXlCb09GZ0da?=
 =?utf-8?B?Wi96NVNPVnQ3N0xMSzB6Z2htelU4MkpWemM3bE5WRXZEWXBwdUlOTFo3clNF?=
 =?utf-8?B?ekZmN0k4MmYwQ1lEOHNQa0ZLeXZLeXpEK3dsNnFzbjFYendVUHRuUXNSaVRj?=
 =?utf-8?B?N0lyZkJRcllZQjdUM1pid3lNd3RkR0J4NVlKMjVjZGdSaWE4RVJvYldPYVNt?=
 =?utf-8?B?SWp5anFlMytyMFZSdGgweWhGMm4yY3hVZFhMdjhrT2x1eDdjNUszVnhNVU1x?=
 =?utf-8?B?OXYzL0JwZzdnNEMweDc2UFIxdzJqNHlJUXVIc0ZaYWpiVDRLQzZacDFoMVZo?=
 =?utf-8?B?YVltK01HOFppZnQ5OCtSUXdhaG52dE03c3JIN1VqSXYrOWNCeXZReDJad0h2?=
 =?utf-8?B?TG92eXdyUUplRVZrWERjRXUvQlM1TEo3bTJoYVNiV0g4YWxSY1pSVUdoNzRw?=
 =?utf-8?B?SHkrLzZ5djlrTTdSVTVaTEh1bGhTM2s1VkdxZXc0Rnhyem8yc2kvdTZZY2xw?=
 =?utf-8?Q?GBBfegb8RbjlY5ptIS8Ykg3r6KgyCri362b6x?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ada090-0ef2-4d0e-f064-08df45795d2d
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:39:26.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9i8rpy4q8tip7olENDoCJLkwTFxYW78RQJDpXd8aTF6cebV2Un51+PwAmzJvvVP4VSSEUiZjloJSF/kxdmgXsJoenbN1XZCbTPIwWPmXTOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB842743

> Can returning recorded here without checking the task's cpuset charge
> the bandwidth to a newly created partition that no longer contains
> the task?

Yes, thanks. The record can name a CPU that a partition root took since.
With no active CPU in the mask, the next version asks the cpuset first.
It keeps the CPU recorded only if the cpuset holds it.

The early return covered two cases. A task that
dl_task_offline_migration() moved to that CPU is queued there. The test
before it already catches that task. A task that an earlier rebuild
counted there keeps the record if its cpuset holds the CPU. A task
asleep wakes up through select_fallback_rq(), on a CPU of its cpuset. So
the cpuset is where it runs.

This was found by reading. A new test case, rebuild_record_taken,
shows it. A partition root takes the CPU recorded with a sleeping task.
On v7 the partition counts the task, which then wakes up outside it.
With the next version the task is counted where it wakes up. That held
in each of 7 runs on both.

> Does calling dl_get_task_effective_cpus() here read a stale
> HK_TYPE_DOMAIN mask during cpuset partition transitions?

Yes. Upstream reads it there too, for every task. This patch only
reaches it for a task with no active CPU in its mask. With admission
control on, patch 29 refuses the offline that leads there. The next
version reads HK_TYPE_DOMAIN_BOOT in dl_get_task_effective_cpus(), as
the rest of the series does. A task whose mask holds only CPUs isolated
at boot runs in def_root_domain, whatever the partitions do.

This was checked by reading, not reproduced.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

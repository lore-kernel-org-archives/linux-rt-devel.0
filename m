Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795008971;
	b=uy++wWlL4DswORdzMgYte2FvoI4SZoj7mx2EUfyMZfY6LlJ1wOn0WIhvaOFyHG0nKFmS
	 fSBJ1vIeCPE/SksF73fr051jQDNR5l+kvagdOz7hLBVROx39ORZYtQnU37SKwPcBM/Eff
	 auaOdkTgKhIiwFtj/tkXAmPj4qN5BzZSVkWEQU6ZYMgCpxxA0BhRlFJSsKUAT50maZkLS
	 GOYQetMwmc4WHS3EEtusJOTbbSlNVcd5qQ86T9xT+KW1icQ0JK370r+Q5DJxnbsvTfw18
	 g0Bjx5c+5XkL44nE9iAmFlcxQybNF0uCzgNbZAysrTrJGeST6LZq5+XQTb+QkNIFfuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008971;
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
	bh=XmjwcrixBdYdShXF3j6BajIoW55pEfUzdxENeiiVaXQ=;
	b=Wsz2gsBxcdph0qGFEsPmxHuHKaHZfbz3ZK7EVsMtIpbvAdegrTSQwjxdui35bjgLK1mO
	 LKUu7KH6QLOkNr1VbIwQ+8bcrf06+q+TAdzk0C78GsxVjdzdfxXK1CCNDUAfE8NUk7VRu
	 +eBeXdNvUbYydQ8/5H7DevSgNtxlTDfSY99y/GAIokGt32CVRS0OjK3Lid8dqxr+wo1RL
	 UEaafzr6KIF+tETRvsJFLKdTzr07dTZCn5rCJ8QlnWH5kEeD25I31FjUuyW+JyqQAnEE/
	 O3PRUAuiNy63GZMysr2GaSZH0YPY0T1levwP7atswdc16yGTdcJFRwuNCu5hffxZhyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=FbB76ayh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.76
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020076.outbound.protection.outlook.com [52.101.189.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8C606A320;
	Wed, 18 Nov 2026 13:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9E8C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=FbB76ayh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKvGT0biK6+KkqeBT60j8yIMPK/KSrXtiuQhmhQAMJbb3xqdBBaUKi62eSlgy1gEn3XojeJJtADjj9CDE7CKhOvs7SQP2vHfeGGwziXl4Uf1KHa2nlJKkFeWEyXoTXQ6CKZxeNME0K4xTjf0KrRGFB8lCZ3cTJhD0u26c4UjpGpKXv8rdZYtTpHHbUKe0A1Ntf3CZb9LKPAl494HJtfQMuR1TMTVBJK5NHyz1GX/hYoFZ54x1J6mrnU+1MY/8bfVEiA5NOD2bj0yVCdGqZIbxbx7AMTuhz6mNNhIJzM++GQT24ZFLs/zwpdQikGLd9FZWfd/2u7i+LH9Q92BzOPtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmjwcrixBdYdShXF3j6BajIoW55pEfUzdxENeiiVaXQ=;
 b=qGi6yUjY3wFmIifjsK79D7G8fDpawxM2zWs4L2lGQt/SxZhA2UGynSr7Y8PowtX+iSi34r9Fgjbsr9lEgYSXViHpDLSFbKV5BlNUmyeFRsJhF73EBZtIjH2NaRjk4qsqtALyVamGdmKrzy7Xe/ylGpBCy0RoP4IVfeqqTP9caiOkZJ0M/vsA2V9gMP29uOg39obuCHHzwspZtPousB/y+BNKz5CHYjX3MY9PY628R3IxyPzSYO6ADPg/dBoevIjmEyj5vYG31kz97mKkp/Ohv2dm/2Varr2fLrblam847B7T0FgBdLVzzkX0BxK91UOCROkHvjbKxkPvKcgVkq5FlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmjwcrixBdYdShXF3j6BajIoW55pEfUzdxENeiiVaXQ=;
 b=FbB76ayhPYyiIOYcM2u7aM2vZEfTHNQYqq8QdIq8/o03XHWG1cWMxU5NQxYG5XH3YcL8G9ApE60/5rnKJtqpUIkT+fZBmi07NkaKtalPnAptpzj6WkmvTLknDFczmqRFlrIcPWDMNid6iRp8Owc1vct4GQw0+PyxORGILhLX1v5el0Z7gbfnjly4dG0wofT77SSKsUyQKzI9rJBq2KiSMsO+a9MbYr0d+qu8XS+Fkhm+vcoPRdB6LQVOnYyhHkGg70dXAG2vadr3u/mMvuXlgRUbeLZLLRY2mIIcxzrsHlyxLGZf68XKUkhzPlZJhCuchdEU0W7OaUzZiWYs6CgvGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB9677.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:80::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:36:09 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:36:09 +0000
Message-ID: <1dc97b46-dd33-40c6-8422-59101516b392@efficios.com>
Date: Wed, 18 Nov 2026 08:36:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/40] sched/deadline: Reset the donor's runtime at a
 deboost in the class
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <299aaf536a1a63c7b496eebe7a6ca20e8f06ad5f.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219000@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-219000@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::15) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 9774d372-2fc0-4164-33da-08df4578e74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|261022075727099003|56012099006|5023799004|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zsr/1qBfF550yZyY9TCZuJRx96xJeyuV3rl+8j10+HzOItFv30O3mSmPez6udrQ35OlegNW1jFC2gF0d00a1qWgmtKUQU3MiTodV97Kruk3kAI5l1/8NMlxLwHYA5uQWBxihWY5ad0DBRTJzfrn8UDjmsO0s9dtKpkhPrYrImDGnEqBLVGtYNZaHk6u9a6vxCht0DwsaCRHqwk05ruP9J4xWV1fMrZxxOEDL5ThJcnvGysNqyFV6dkk66VAkYC1nZ0WqH68UUw4L//3T4dLCgvvlaPkgQI5Alhnlc8ikvC/NS9CL/DGsGlZ1WpF9Hm/HVvyAUYJ+FwvOk5gYtKmyDEFBL2HTNuzS/+GDCKl5Oj8O6Zk8DJt9RHRbn52lzifh8fQ/gef4AsQUEXd4ZHEpV5g/cPOxN5YR5Y8ju/UPWW/IWXL3qKbQU1hWxEMfNrFK+Q7CXX8uSgyfV0mneCs/od1jIoGKtKdqGj1DEIpbtK5HnrL4fr8xOBywgRG/6QC8RLS4elNCOy/hCr2VYQ+WJaB2GKWDzYMLz9CYWqkQTUz2xKw7+iW41Ujfs4Za55gJnxPfDtWmHHoJxXXDS38FWbPblklPHdr5LYnPvPOTgJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(261022075727099003)(56012099006)(5023799004)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QldQK1E5dkRCNWVOT0dLbnh5WTVUUjJ2VHlDbUE1OUl3VnA4UHBOUFlaQXFO?=
 =?utf-8?B?TGN5NVRuZkRwby8yVWpEd21hZEZjVHV0enRLOXZ6ZzIvSUUrTTcxTktYY1RE?=
 =?utf-8?B?YzIwSFZhaXkyVUV4RmFSaWhVRXRrVU91aFZScjJSYmhyNFpmRHRlcWZVcSty?=
 =?utf-8?B?dlVKMlFKRWlXeFZkTW1McFk3S0FmSmVYZ1VMMVlyWmhPQkJwdEhKYm5mVE15?=
 =?utf-8?B?MUYySjJmSFo4UHFaalFkQmsyMkRPcTdsNmVtNmFMK3phazEvMzRlRDNJUmVo?=
 =?utf-8?B?NVVxZ3RBUDkrZk8rRnpzL0RWamw1MGpGaHlvVXYydjRzMHIwUk8zWHFPRXJh?=
 =?utf-8?B?ZEpNKy9FMk11SkZGVkJadWYrUnovekFsejNBMWpGMlovUHQ3U1NqRytJQko4?=
 =?utf-8?B?VkpZMGprTWZ1eFFTRm1ZVWRCTHltdHZJbzNmQ1Z2bW5yZWt6UXMyemVocHZF?=
 =?utf-8?B?MUlobjNMK1RWSTVSZ3dJTkNON2Vwdi95amxSQWNPSGxnSXRVL3AyY0o1dDRz?=
 =?utf-8?B?amNFQStGaFlydmJmREpsRStLYWtiSGdXM3hpQmlwSnhJWFlLb2MwNCs1SklN?=
 =?utf-8?B?eHVVM2NHTmgvSWs3WEZXVEpjNjlrdmJHR3V3em91VjVLckx4aG02ZFByM2tI?=
 =?utf-8?B?R3l2MHZ2VVZaMUx0eHk2Z0toOXlkRGkzQ1U5RWRKd1VCU0RrTmY4M1FXTEdJ?=
 =?utf-8?B?TmQybGx1TXVVK1BxRnlGYVBwTGszZjVjVHF3Z0dFQWRXZk93OEpxUkd5VlBW?=
 =?utf-8?B?YW1TSFNPSkFuNGk4eStFa3R5SDM4NFgxd2crakZ1MGh6NFk0UE9QN1hBRjRx?=
 =?utf-8?B?UUFXcXNqQVNwczh2cmFvKytDMlNaTXV0SWhMZnhSQyt6MDU0eTRYTDIwU2hP?=
 =?utf-8?B?Rk5pMXc0bWw4TVZCbXpTTm1ROWZqZDBDdlppdlpXaERMbVFndjl3U3A2Mm9G?=
 =?utf-8?B?SFpVMitGUjdydytRamxDUm1jRFVCTmZtOURiWUNuSVNRTVVldFdhNDBPMHpQ?=
 =?utf-8?B?U2VlTG5RL1kzNXNlWmZRVlEyZjRKaUlNa2VmeXJoRzJEdW1qRFluNDZ6UUw0?=
 =?utf-8?B?eUlablhqcUloZGc5eXZxK3h2RVhxNXJ0MVdERnE5cjFxbTZOUFZwd241Zmpz?=
 =?utf-8?B?YTRvTVg2dXhWYzdwTkdmT21VTG02QjcrN0RxR2k0T2JBZ0pCWDcyUmhCN2Nj?=
 =?utf-8?B?WSsxSm8xSTYySndRTGd3Q1QvY1ZSQmxTMG54bDdBNEFKTDBmcXZWL2hmL25r?=
 =?utf-8?B?MTd2VG96TnhDdW1XL1JPK1BQRjArL3l1VWRMYjQwajcrMHRKdmxuZnNrcmZZ?=
 =?utf-8?B?SUFZd2dsbzFVR2MrYWtkRzNtWVVERWNkdTJkWnpRNHFLZ2dKU004cnVkYmtO?=
 =?utf-8?B?V1NzTmlSejlJcUt2TTJ5bGFiMDdPQnhwZ0Q2M1hqdVFjTm5SNXJEbVRmV2RM?=
 =?utf-8?B?MmZiNEpESVpMZXlOQVg5Q1A3ODVoTlJrMmxGZGlwSnRhMG1zSlEyTUZvUUlw?=
 =?utf-8?B?MFhtOTFxdDVKVUExaDUzMmxKcTVSZkx5S1paUUFkUkxmTHh2SzlrdzVpTUN2?=
 =?utf-8?B?aG95QjVPN2I0QkpMdStRK2dKZUk5YitkRFNURzkzZ2hmT3ZwWnhyTEdVV1pw?=
 =?utf-8?B?TUtJVUNic2w5V1VrSjVSbzM0REVJV1JoSzBkbXJ3TDRVMEVXWGUzZFVGdG5m?=
 =?utf-8?B?QWdJdVBvMlV3N2ZmYjlqNW5lbjRVcnBFaS9KWHY4dHAzN2lVcW9ENkV1ODJr?=
 =?utf-8?B?UE9ZWHYwcDdvZ2JyOHdxZ2lTS3FWc2VlQ2ZwZHYycnRnU0NlMC9iSUMzYkFM?=
 =?utf-8?B?TDNFRGdzVXJ2TlpvbFArK21YT0N3V2JZdTlJL2lKUG54Q2V1dzJNbEUyNG8w?=
 =?utf-8?B?ZXljMUk2Z3BBZFFIWFVHdXBCU0dBclBaTUJ1Mit5UlFJNWZkVlppdERNN0dF?=
 =?utf-8?B?dUk4bTZmUmRidzVib2VnVGxsWTNMQzhWczI0NW93bEhCVnVYc2QyTk9aWUlR?=
 =?utf-8?B?V0pBN0ZkSzNaRmJEb0lBT2JFbXljZElDb0RtYStpaHg0VS9sWWZLWHBYNEJ3?=
 =?utf-8?B?WU5NYTM3NUU2N2pUbXFrUEdaR1NUTkthUmJIYzhjQWFaZVh0NDhncUxvbXZT?=
 =?utf-8?B?ZHFkbkYvOXpyeHhBeXg5OUtWYVc5bDE3RVJHSWZZa1lvQVlIZ0RNaWc1UzFC?=
 =?utf-8?B?aWR5UStMZlIyeFlndS8xQ01hYUt5YnlEWlpGdEVtbDhqNE1scEp4ZlQvWnVC?=
 =?utf-8?B?Rks0cEg1aHN1NkdBLzBZV3RHbERIV2NPaEEzUHN6M1NaeXdtNVVkTU9VYS9L?=
 =?utf-8?B?cllWNThwRWZMTlNLYW42d2llM3FxMytLZ2gxT0RBWmtNYWd2R2ZCZ3RCa3c3?=
 =?utf-8?Q?dAhVo9dHRri/PNRKa4k3IPh+ynC/BTjcbnRMx?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9774d372-2fc0-4164-33da-08df4578e74d
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:36:08.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1dcMkhrMhpEMAWCbkqKf4CbCb+Db+5JpcRq4ZLsPfQnv6oV28oX3LUfiuXEKEVINtne40av7MXDe9FngvSWwzrSOOZL14lec0n5W3kWAEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9677

> Can a SCHED_DEADLINE task skip dl_deboost(&p->dl) here when switching
> from one deadline donor to another?

Yes, while the boost lasts. The first branch does not clear
dl_donor_refill. The flag set by the first donor's refill stays set
while the second donor boosts the task. At the last unlock,
rt_mutex_setprio(p, NULL) takes the else branch. There, dl_deboost()
starts a new period. So the task keeps nothing of the first donor after
the boost. 

During the second boost, the task keeps the deadline and runtime it has,
as upstream does. Its own new period could indeed be earlier. But a
dl_deboost() at each change of top waiter would give the task a full
runtime of its own each time. A task whose top waiter changes often
would then exceed its bandwidth. So this is left as is. The cover letter
of the next version lists it under "Not changed".

> Does a task that still has SCHED_DEADLINE parameters
> (p->dl.dl_runtime != 0) keep the donor's refilled runtime and
> deadline when leaving the deadline class at deboost? 

This is the same point as on patch 10. It is known, and upstream does
the same. A return to SCHED_DEADLINE before the inactive timer is
checked against the task's own parameters, by patches 35 and 36. The
cover letter of the next version states it more clearly under "Not
changed".

> In this cleared-donor fallback (!runtime || !deadline || !period),
> should dl_note_donor_refill(dl_se) also be called when
> dl_se->dl_deadline is non-zero?

No, this is intended, as answered on v6. The task has parameters of its
own. It keeps its own deadline, with no runtime left: an exhausted
period. After the deboost, the next update_curr_dl() throttles it until
its next period, as for any task that used up its runtime. Setting the
flag would make dl_deboost() start a new period. That would be a second
full runtime in the same period.

All three points were checked by reading.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

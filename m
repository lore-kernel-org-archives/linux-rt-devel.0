Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.95
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794193025;
	b=ktYautM+NhLvTeWJ+0JiIbSlMjHgCpXLLPx5zuYuITwC/l2+j4xZmLs4nfuRWQjGtdcB
	 e7VoXOMPzzzuQtiKy73CjBF8d139QACCv8jItOIf1FwP/S0FpAtRCTx7JkyrZZn4BmteR
	 sfU+iSOrhg9tkT8HWlcqsF+Cvu0W4dm1/RnS6JGIH4OKxXAN0sGjEu/GgGb9nYSObiRUn
	 BA2RYdoQrJNhST9jQBsgYNXTEDNmylua0Kj2s5PTbsBm8ZPwxSMgfz32CdUOKL5MaCooP
	 W0xGx8Z4dJhrYt9FH4G4Fmz1naX8j5zpXmpoJTWLBBYX+UZJNVTQhBGGIVagylo7ESA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193025;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Xnme7yKUwdQaDiHIT552cN7iSCPO5ynXqvQjG0Lz/Eg=;
	b=ap9IGWp+whmVjH1c/EZQ8kjNwfVrH45dXldo3k8TVDUopg9QC6bJlD1AmtRME7053lfa
	 gpcx+UdRahwR61uSJ19ERox69FXQTo/uulYEYA0Luy2oJSqEQhwOURxzJ3X029Xd97uTN
	 QF7cSsk+OBk0Lti7uikGcGIJT35n8JsyManJe90XyVf4RTKx4Khrqx2UQIa6PfG0UQs+6
	 koYR6909jVTJdwnUaWuaSVZvTu1PIHxVOR5Tvj+3DXqYJ0Q2a8/ctxxBl+rGyCgiFZYtl
	 QcB15l4B0h9gTshpIiUmANVXHD7xhswqPHJbtoVNUBERydRjWJ7CG5KuQPfzR7ba3fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=NOJi2QQI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.95
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022095.outbound.protection.outlook.com [40.107.193.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C279C606A331;
	Mon,  9 Nov 2026 02:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C279C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=NOJi2QQI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6Kt1if8DTiMjcbyXN4Mtthe7FpV4Yhe7v3VYUoEOnbo+3U+cT9jIZ+wsLZ/rXDVzgx9P2wfXbUCZgkQpMJjVZWAe45eKgmz4Ti1ylaI0eG4Rxx65ANNHMAzRRl1K1O8Xkz9z98FYNqX2oEj/9RqCZRVgwjbyo9rX20MgNL0k9/Db4X3pdL59P5uWd7pIV2IxRrcNFxUEsXseYma52zSJlSP0MveRuhjO7Zhl45TK3Z+c3+YtSyPtroFnk+ZsmfPIt6uUbME1c72HlhzFL//smom7PdVkrCD+03SvFO3AxmZHiIElg3vaXO6W57sWCwfpoqGVRPPwsn+T9RBa9N7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xnme7yKUwdQaDiHIT552cN7iSCPO5ynXqvQjG0Lz/Eg=;
 b=tH4Rhulafy9htN+ERfRdm0ym7v3agt24s2mmpwRS482NSRQROzXjszZat0eO8ahNuKclr9G9ebHUcfwo85fqm641jRCPdW7YESby1MaNq/7HyyLpPbiPepWi2Fl6vj4WaGYjqwwwGgjE2aWarIdfSNF89qzCTCOB+BW7LuByp92wH+kCY0ggiaOUaqz8tnCqysBU9GWk3k8w94RBzYhwtLt6UiFOqDSvr+/T7DBD0TAXZfJiJTeJyKGTpL/1uFXuvxo70d8BPMCS6UPxpnBU4mNHQOqLKE8D9qTID8663ryh/4eCJJz/z7LL5evtw00VUtoQDCRPHG88NrwtcYXsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xnme7yKUwdQaDiHIT552cN7iSCPO5ynXqvQjG0Lz/Eg=;
 b=NOJi2QQIFZr3dlJOQePzjeNvhiIIOdkwab/dTdyM1yksiVqHMUh9hHKY4JICWC67nM//itf+aYUTGCYbAaOtMwgs0l6CAKgsy5yxE1gYjV7EqfnPjN7YNDq540GCoO6V87MXoDuk7w1F76q5MM8A8Yu0HbBhoGFY4aflnCt782dyqXOkBWSoPyeDm3AHORgJgRhuOd/5AmXCArTYuFGPPr/PZ5Z9sHpDjLfr7zlGKcKn81Aqzyz0nylBdMLp/f5yvpldXD786ILcteL+K1qX9Eas3MoCVigvvN8FkpLxitIqiMfUi786ZGjcEn+IXuY2BK4d1Ox1+fnQONrHU/qEYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB376387.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:c8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 02:57:03 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 02:57:03 +0000
Message-ID: <94d8d7af-b04f-4c59-ae3b-e693d4457a65@efficios.com>
Date: Sun, 8 Nov 2026 21:57:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/29] sched/deadline: Move a task's bandwidth only
 where room was made
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-19-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-203951@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-203951@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::26) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB376387:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd773bf-839e-43c6-4aeb-08df3e0d21a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|1800799024|366016|4143699003|56012099006|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qAhlfDJ/KMmYxprSpfQqe/SyWdWsYlXpP0vuUKT0JYWIGT1KyAiFTTItik/pTCLWH0r9KZiqJV8O0Zqc0BNdQQgTSzBbzEXwjNIPvw5ILr4kwmVkpobVJcLEqOFt8Ifq+txI0V+4ZglMrlU6qzMhotLYCulD2zavVl9PJ22lVJpXs+WqCSCRmJWLACXTyU6mnzDgMsv1sssHQSsnjbTYcNldqNM5ek5i366vDlvAd1u9kv6uqR7vSxXvxkF7zzWFN0iEcit5i1sZlx7UpiAW5CALTN/p0JfM2t/peIHGUsx1/RbMXwjjBaHuW6Xej3z9XSTISJBe8TrlVMpsStr8/2pCezzjSQBdkIQ5zT/eFcgUcUajBrgvokw6p3Js6nAq/cY9j3jQvx/N47M2qAVzavJPwyGq27EWJcV7fdM3qfshCRyJmt8ksb+TGPaa4eWdOpo/NKWodRyydCg/n/fswvYeHHpYQFYp0pJE3AbTNW/PLC7/VZTMIy3x8LcjG/v/UissxNeXjOCRvUOHxt3laQhvQWW+/3cZkpLGZvpAsaovkyFZBiPTlVCDYfZsASMzPPDQUCOeK/HKkXNmjqWKJS7Y1R2p0OpeloF2plYpekQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(1800799024)(366016)(4143699003)(56012099006)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVY1UWkxbHhnMWhpTFdkbjlvbVJwZkNqSjNaZFk1TzBGbGNWSTZ3TFdPT2x0?=
 =?utf-8?B?Y2xXYjEreUc0bUREeGkrbUoydUJLN3hsc3RtWVJqT0Y2RVFsOVAydDBxK0Z0?=
 =?utf-8?B?U3J6Q2NaT0tIMGMwaTZWMm00MXMzeGRINEZmVVllZzhTT1JHTUpLaEYwYmdD?=
 =?utf-8?B?bWlVaGIvS2lzRHYzYXFXMW5qYk9md2EyalVsOWxyOGJFUmVDamVFVkl4RkdW?=
 =?utf-8?B?RGxPRyttSlFVYlJXSmhXbk9yV3MvSk5tTkdZWTF1eHdmSjNXT1QvdStscDlt?=
 =?utf-8?B?Z0h3U1NGQkYreWNHTWJNQW5ReXNsSk9ONE05RXdodW8zd3BHVDBqSmI5SU8y?=
 =?utf-8?B?SnN1ZFBpZ2YzQkJXVGdYYUVvZDFSUitlTnYwNjdZRXc0WDE0WHdmTWZhS3JB?=
 =?utf-8?B?YjZpNkltY09HdmtzaHRhR3M4MUd0UDY2ZXhQc0JMcVZvbmlHVjUzM3VpRmZQ?=
 =?utf-8?B?bW9pQi9UaG5OYStUdlZEN1RqNEtzNkg4TFdqMy8yRlZtM281Kzc4RXd3TDll?=
 =?utf-8?B?U1pKa0cyTDhEUnZEbGtzNVM3ZmtZNGFobXpJVHFNM3JJem9FSFBVcUZwOHht?=
 =?utf-8?B?M0EyYmVZT3p3djFPa1VROVllT3h3NmdDeVBrWnpEaFJad28rNS81QXVzdUx4?=
 =?utf-8?B?Y29obHJENzZNK2tHWWFoUStweTFXMC93TXlFL3kvTlJaMzdXeFhxZVpFdHUz?=
 =?utf-8?B?MmE1cWRLb0V3NTArcDBqeTZlc3RtZytGTmdQVXIvOUV6K0hVcWxKYUhmRnNz?=
 =?utf-8?B?cVUzZkovTzVFdmdnMm1wWVpWOE5oZkQrTWNpQnAzS2xiTXVVWHNOL0pKa28z?=
 =?utf-8?B?MGFYQUhNR0NkZ2FLZlZiVzhGUFpPbkVlK2VZNG5DcUFqTDZKRzYxQUJXRVBN?=
 =?utf-8?B?V3RPVHcyNklXVnpuN2VPQ1RDQ1d1VzlWM0dRVUZLSWtYdW54NjlydXBML2Zi?=
 =?utf-8?B?aWY3M0RRYktyc1YzOU9sa0FVZ0FUS2s0VGtnQ2YvcytDVEYrTVFOd3dHdk9N?=
 =?utf-8?B?eHQvOU9QNnNBS2JZOVVwbzlGREtGQ0NqSUp5NjZocGUxM1cxbFMvSWhMZ0pS?=
 =?utf-8?B?Qk1ibkp2UXVHU2x2U2EzWVRwL0ZiN0o3aHN5ZXR0NVJwVjhQOStFQkxQK2Jm?=
 =?utf-8?B?STcxRXJNdWg0NmJhNkhPUHpvZkdna0hlTVlyMngzM3FUUk4rZy9Ua0tEQk41?=
 =?utf-8?B?NDdGZ3EzODh3TjJMSklPazZOVmFPTzkydWF4NnBpczZnYnBuYVR2Tk10ZDhu?=
 =?utf-8?B?K0p2TlR3NUtWUEZPWkdEZjl5U0RrSm5BQWVESEZyaFNwR1d5WllvZW9DdTZ6?=
 =?utf-8?B?R0pVQmtCNmVDLzFTOUJJZW5NVVZVSDJVOGZyNno2UWlNVERCSHVLM3BOYjdp?=
 =?utf-8?B?a3hQdFpXajBWUFVVMnRFL0MwUWZXaHdSM2ViV1FsZG4rODFiUDdtTmhkTmk1?=
 =?utf-8?B?TDE5OG1seDdrcG15R0RoVXQvV1A3LzhtMUFKUSsxWWZ1UFhJSHVtd1NlQlIz?=
 =?utf-8?B?aFlGNXloTk9qcXVvK3RDOXJhQ2U4VWRUbVkyRUE3YlRyK0hkWE1JSjJ0QStk?=
 =?utf-8?B?Nk8wdzRlZGxTMTVITVpQZktaak1lcGFyWU9qR1BpWERKMUVXOE1qVUNISXhZ?=
 =?utf-8?B?Z3hwZkZsRFVwQ2RLOStrNmNNL3IxUEw0anRYOVpPZmNhY0t3RVdUcUNGWWpH?=
 =?utf-8?B?eE12aExPblc5UktWd3JvSlFVSDJkMkxjeHZqNFJYN1ovNm5NVHBLL1VRaEY1?=
 =?utf-8?B?MjFFVUowbnBrMTR0Qm5Hd2pCTjRHRU0yWmtJeTNJSnRtWFdNcXV5Ung0OElY?=
 =?utf-8?B?RHBSdzMwcDM2TWVTcGw3VERUY0g1dTFqbUsrck9nWXAvRmV1UDk1UlNFQzc5?=
 =?utf-8?B?cFY1eHhIQnZONDR4YVJWRjRmNXlseTRBczcxNWRYNnBwSjA1cmJpMDNkNnps?=
 =?utf-8?B?OGoyb3kxTk5scVIyY2NSV1VvZzUzVUJvQ1V3OUFJY280VVlXZWgrWjlLczhF?=
 =?utf-8?B?UkxqMmlDQWJ0VzAyVkRTVXlWOWJYSzR5T1dqQXpMZ2xnd1ZjWEFjMGp5Yi9D?=
 =?utf-8?B?REJvNUcvOFZjbm5kSzM3a1h3NkxPSmRFRHE3VnFTVVAzZGcyYUp2SlZzS1RG?=
 =?utf-8?B?ZTRFT1cvaXVhcHovZGY5dUMrZDgyamh2cnlpUzFHL3dNZmNMc3RQRDlBVmg3?=
 =?utf-8?B?Vy8vMDQ0aXFqSkxBbXFzWHFzYzFUQW1LUHNUTURwaXRjUWpDVG55MTRYcDVL?=
 =?utf-8?B?ak4rbFg5VEV1ZXpvRWJzR0p5ZEl6R3NVeEF1UFN1Z1hPak82REc2OGE1ZXg1?=
 =?utf-8?B?eThkVFZMK1hQb2V2ZXZRVThrNUtOcE5JNHU0Wi9ma2kzNnlacmhKUDJhbzNU?=
 =?utf-8?Q?1E9kaROg7sWK1H1ZS8LlrV7q92trv+2Lrp0aiFWq5PIXD?=
X-MS-Exchange-AntiSpam-MessageData-1: ZN1QMvxWyn2eEfsoJ6mUaccaBZV0D2jJJpA=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd773bf-839e-43c6-4aeb-08df3e0d21a5
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 02:57:03.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3riYGa0rD5ZwpXkgyo2aJlwIUr23rOl19GSOghP7s7LdWTqjq0eerMaD1WNEOVKjzQ6ShaWkPpotuIPpvKGW2SgKg5Xjg1bG1NnsjFb+PM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB376387

On 2026-11-08 14:30, sashiko-bot@kernel.org wrote:
 > skipped bandwidth move in __set_cpus_allowed_ptr_locked()

Thanks. The skip is real: an attach with an unchanged mask never reaches
set_cpus_allowed_dl(), and the reservation is given back. Both setups
you describe end at the wakeup, though. The task's old CPU is out of its
mask, so migrate_task_rq_dl() moves the bandwidth when it leaves that
CPU. A running task migrates before sched_setaffinity() returns.

The lasting case comes from dl_task_check_affinity(). It tests the root
domain of the CPU the task is on. A task moved asleep still sleeps in
the root domain it left. So sched_setaffinity() can take it out of the
root domain that counts it, and it then wakes on a CPU of its mask. The
next version makes the affinity check use the CPU recorded with the
bandwidth, and lets SCA_DL_BW_RESERVED skip the early exit. A new case,
affinity_moved_asleep, fails on v5 and passes with the fix.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

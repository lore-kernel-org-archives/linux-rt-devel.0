Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442505;
	b=Ck6CMcpjfvRov3idF/xjm8ZFfXTgplhsaNrsfvHL4NFpNHzpzurmKGePhjGhp5ftd9BJ
	 EGsJYQEcqIRaDoKhKzp/WxFWD3/6oC9x6ZgV9r71l2xE1jQbk90RulWyCkzVgGjNw7r0W
	 DigdpKLK9ob4cfuT7cobRPcoNVHofv40asYMbzJyj136ecAzS4ErM/S4W4wLnalTuQgP0
	 4lfBcqsN1A0X9l+FCpQlgh+x4xMHV4pXjN+5wyVMKcmiA4/mCKZ8S0Bj3GFbvtuiIhv1o
	 AA4xuRoxul1y56XepMLGaMPSA6glZRrJ3eFFJmgilokbFjBvP/cISUrMUBKzJcORhaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442505;
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
	bh=m7V1fUTX0hvstYgFYLYpp5uyiiQLTEBhzsYlqViWMPE=;
	b=B436R5actUn4RSEx+eydGvpczKLV0PuEbAU9VHgpqsSZDF/YyL5Eyd5iUVyzU5NVc+AV
	 3V4ILFIk1l6+OqUU+haVdfSfiDTSK8e3mh2tDNUvRgiL6fBhlDAbSxHP7GlfR5sgoQLmK
	 VmIa1O5yOhgBN8j4L4jYOJGHwHb+MK2mJyMeW6xAFjbOO0dzT5lQ6vRuq4X25Zz0Y/RbS
	 TMtqSQlE3W4lRsT/5rvdzLKZmuS3vcFaj+ThcyYUxgO0+cCvplDivfu73DUSU9YPxGBNc
	 C4R9xAA7nPsyn5onXalM73tqIWS92zcE9/Z3IVfu4KeYvuEWAMfTns6d1E/htDCeEMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Sgx2IDGr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.108
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022108.outbound.protection.outlook.com [40.107.193.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB6606A327;
	Mon, 23 Nov 2026 14:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBB6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Sgx2IDGr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVlBGmtjphSE5yWHd1Zpk67FaXJYcexrsDOsHGiGvFQaCkhtrerGSo/Op8OHq9pWThNVPmLk4pfqUtABcVWpQHMs1MQTYB7m0Zr3QGusRA7512LMQPsDDuRq8xF0dpOta9Q+m0+IFh5FAp8SJjFIcgGI5NUDoEw0huoCZUtR1bKbV0EiTJQ9im0DEuu9hhXrNTD6US29LjX2JglqZgpgi6fXsE2k85e2ElYpwz6DRVE1401DDVFTiKIqdTvUmq0WgGKaeTh1MNIu5s7gE6BUZ/33+A8/5VxdXvyp78W9JuK9Wg42hESOoulGPYtdM0M3kFriKsXJ0P76xpYZlKC4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7V1fUTX0hvstYgFYLYpp5uyiiQLTEBhzsYlqViWMPE=;
 b=H+HfVx23z6AHw3fVoHwuHCb9VvAEgXPB1Z+0M2xwJzoCdy2iT/r1iGwC6UEHDOdIPLBgIs1ScjXtlFoSVfdh7bhF5vvD+lT4156J9TFgrr/KxB2bXlTyxBWeuo0DbFDFdXTbw3FQ4hnnEohKTZKTdJAXOmxvkYMQhgiC5LaXNJ1Abm1Hhpk+HONUI6la6cOazstMBXwodfavlS5HVw+mk68VNOi7kYdi/0aimJ5cE8LH2FXr5mHNl4Ap1z48w72z1SAd7zTfXrVCrmPWydjmZQxV7Tp7rjBCuxpXrWzUuPWVh5EAZ0LDhWSRurJxz/3RGgokKz0KcNvdYZ/9xlNSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7V1fUTX0hvstYgFYLYpp5uyiiQLTEBhzsYlqViWMPE=;
 b=Sgx2IDGrBVb4Z4D6apglygGJJJD8GmbZ6tszbEfa1NLnMwjFwp6eqMWL0jdkde1Me0VUdAzCcPPirZhJmVCDagH6k1YyzSe+6tfJZWKQ5DLe5/tplEcdsU6G0uCBqYwir8cOemjNc70kE9LKGcU9z5puyUpiqizYAYbTp3KjMuivBfAqk88eFu/MTrO76rM3ZX0AesfGzZkvgQr0iZjlpMJgJfpnucZUxgRBzOe4XEKjTcd9vTspqST3lCZdAnWpIv586qQtaE3QDr7Ws0ckeJa2ZZ1qo+d0kVDUHWNUqA1UufZzHtFX/b09ykyXEZioqWKnbgHsf/y0n2CZefXJPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQYPR01MB11558.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:a6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 14:01:42 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 14:01:42 +0000
Message-ID: <8c0ef611-4037-4797-9c73-ab12edc8cc3b@efficios.com>
Date: Mon, 23 Nov 2026 09:01:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 37/40] sched/deadline: Keep the start of the period
 across a change of dl_deadline
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <3360961974ba9401f7d6d4d7d5fd513db04c9fc5.1795207233.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226164@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-226164@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::19) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQYPR01MB11558:EE_
X-MS-Office365-Filtering-Correlation-Id: 4712f495-78e0-4808-a1ba-08df496a4d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	QkWwXS3Mx1Da2XAmcA4VQnJWyLVb6+Yan7k2d0YpLeEP2q/3reFIkT39Mp88xLYgapwd5TbbFyJInir9sptx7cRcA8Qb3JhTxMzK0G+NylS+gCe1AT7BOd2/tgsSDFIXpdBll68IEYkd1Bm+4XVzp26W1JUWD0bTGgDwAJfgMDvy7YLcJQhlyumBVWdlDra5nKqhEZcniA5GsYUXcPxA68zX41HpjI7t/RvISNL+HdSByTfWSMZmdo47lNvDyW0yxvdjhTBbEv1D0Y5TSLR8wqt6u8Gw/G2LnFDRB9mdkGYP5hpMXX4NEXdjBJXbp/kh//5ItakpMf14+3ki0vK3cDUo0Kp33cuPeXL8mFzdYrY5bvaLPgZePBh5ytF1U1k8djL4gTxZU6sKA/+pPJnQgVa/Wec5mRXQ+0YmyELrif55mkXBQxrBA8NhZw+g8rKI4vA185LZtILE1LJmJXDceGJiEC7B9r5DPZzOy+3r4RMdlzHJY8hD1nyFE6IZrPKNmgbfybNcA/OcQ1WV/+ZU9oo2DHOY9E6d+bQxP9fBkNops+OIq02hBrXI3UqqURNzjYbo8j+Q4a+TMx6cU3QHZrMpVFr3b4sZWkLMkzMyEgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bll4Lzg3eEJldGNoL2FVOWNqMFpXZXlRZ2dEekdIVStrL3dJRjU0dGhiSVAy?=
 =?utf-8?B?QWtKY25lOEZzWWpXTzllbjV1dHJGTWZNNmxGcjdlbzNwbVdwUkpZb0UvbENW?=
 =?utf-8?B?d2NSeDRGcEJMSG12TDlzbFBqUGV2MlRqVEZZcS9YdmdQdEJVNHNUUW5Ubmlu?=
 =?utf-8?B?K3htM3FoRkpsTmltT0pBNFRranh1dFNjTGp5eXk2SUYvSEZib2YzWnA5enU3?=
 =?utf-8?B?ZHg0MlQ5M0V6MTh2dUJGSktpRms0dW1CNWZWRTV4djIveERxZks4THpRcFNm?=
 =?utf-8?B?ZzVnNUc0UEN5NFNweHR5UDNZdFhIdi9qTWdES0dteHFhOTNSWkdxczJsVWI0?=
 =?utf-8?B?dFVaUnRoT3MxVno2SkdGQjZ5L3FVUWpXL2lPc2xPNm1hMWJLQUNUMWRyUXpX?=
 =?utf-8?B?Q2xSNzNYUWFLM21oSDE2TE94eEhHZ3NmWFRma3dqYzN3SHRhZkpuRXRRbllC?=
 =?utf-8?B?WDU2V1BpOFFLQitUam9kNzhDR0pVcnYrWmF1WE5IRHdPdWcyYjV1RndtT285?=
 =?utf-8?B?by9ZVnBCWVVyUjVVSnoxWkExTnBVNGtrcE1KTzM3OThVTHdHYW83K2wxWUpL?=
 =?utf-8?B?VkxmL1AvNkdrNFI3alplcXdLZDBuRENZNXRDcitiVXlheVpTdDVVUXV2K2R3?=
 =?utf-8?B?aGs0QmpySTk5VjU0YTJYZ1U5V2kzUWxsTWtRZlFvRlZZRWZ1T0lWWlVRM1JW?=
 =?utf-8?B?bE5IUHdHZHNjNVBaeUh6a2M1eXFNQldiREpCaEtaVTZBOGhJcHlrZDl2ako1?=
 =?utf-8?B?SnZhWjliYXVWdWVvS2EzMWF4M1RiYlBLNjMzZXlYQzd2VTRqeUQzeU9rblE1?=
 =?utf-8?B?eC9SY29IWjFKVWNSbXBERjlDLzFaQy84V2g3N3JseUFaRlpHd3hPeDR1SlB6?=
 =?utf-8?B?S2EwSUhoNDMyQk9xNGRzaFhUdmw0cHF1VTJ3eEhCeFhuT2FubnhMLzJEd04v?=
 =?utf-8?B?ZUNqcGVnNmhPN1JoOE1KR0FEQ1FqTnU1amZ2NUtCS3BRd3pTcC9JbjNsVkhB?=
 =?utf-8?B?K3ZnRVdNS3IxNElFL24yanBobk4xR3J0SUIzRzArZUtsZzdBK0srTzI2ejl4?=
 =?utf-8?B?SEtTeGd6SHJtUnBHWHpOelNCam5ZYXZ1QW9hWm0zRHcxbDgycjhVRE83bWwy?=
 =?utf-8?B?cVp4SFUraTREdkFCd2lPWm9FR0Jic2hOb0FIV3plTjJZSFE2SWd0cHVNeDho?=
 =?utf-8?B?Y0IybXVXR200UkdVTktnYnc0cUJ2QzlQNjJQOEhOS2dUeHVrNWRVVGJlWEJz?=
 =?utf-8?B?b3BrQllpcFVpTTlHN3RuY2lPaDBCL1piUTZXbkxNWEY0c0NLQjB1SGxLS1Vx?=
 =?utf-8?B?U2VtWm85a08xVWZWd2lQVmtkV1lvSVZPVWJzYzhOUitEL2JQckU3a25HSmFk?=
 =?utf-8?B?bTFZVWRRTy9hZThEYkROcTBWSm1IdVhKd05BSWNjTHVrTHVBRlZlQk5aMHY3?=
 =?utf-8?B?RjhDVVZ2NkhuanA2NWpDaHU5cXFuQ2w5T2lZV3pQUlZ4aTU3ZUNKVzBPZlA1?=
 =?utf-8?B?UzJhODdCcHJ6bGNmKy9PazI3aDAycEhFQ2pmOGZOTWxTTngzUXd0QWtwd3Jl?=
 =?utf-8?B?RG5aajBtLzl1L3cxdHJJTUJmYUZPcnhUTVlUakc1dHhLUUZnWVdIMkxKWUg2?=
 =?utf-8?B?NmszN0FsL1JSTXkwN1ZBZ2dJKzRQeEJrcGw4eVR4blpEOEtqT0R6VVVMYlNh?=
 =?utf-8?B?SXVxc0lXZzY4WjZrSUYwdWIyRmZuU0Nqd1B3UHNGRXI5QmdYMjk5ci96QW15?=
 =?utf-8?B?b0tIbjZIdVlpRkRqWnM5SFQySFlSZlR1akh5OEN2RFlzMEpPUmNRVWJuSkwv?=
 =?utf-8?B?TUpDVUJvRy9TTmR1Wkx4VjE2K0luTXFRVUNMT3kvakViTnVTbFRTTUVUcm85?=
 =?utf-8?B?bFZjVUZ3cVN0VUExVDJLSTdscERMVVg3NGwzRUFtUHlPSTZoa2VhRy9RR05C?=
 =?utf-8?B?QVVoVDk1VE9mU0Z0VTJMMXdGekJIMzIzM1dZR3RSYWJ3U3ZVbTNDSVVsbzMr?=
 =?utf-8?B?dnF2NW84cnNaZEJtUXAzS054elZnYlUzeTB5SXNEWm1NMlhnUXZoZ3BkSE5P?=
 =?utf-8?B?WGZITkJJMVdvV3hlMTFyOHZtamJKZ2hJWis0UUw1YnhxK2V6N3hzODRpWHVH?=
 =?utf-8?B?RmdveG1zU3lxSi8wK2JnZGJicGVpbzU1MHRwSnBhNG02VHFMRDVhUjJIVEhJ?=
 =?utf-8?B?R29NNEVaMEwvWC9CbGNGZUZwUjFyNzJGTGJOOW1pVExNak1ycWd2dFBjdkZn?=
 =?utf-8?B?WjZOTTZtZXY3R1YzbUs1c0JqWnZteElvSGxkb1BwK3Bkaklpd25pNitjNU1T?=
 =?utf-8?B?aHVpUnpUcWcrajNzenI3S3d6K3Y1T3ArcGNSWm1Fcjl3b01NNjhGc3luSWds?=
 =?utf-8?Q?zrk9I2xGcdiOTqDz1m/zOmPNsjVPe+MvIzeaN?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4712f495-78e0-4808-a1ba-08df496a4d5d
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:01:42.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxqbswTPCn8KLhmXQfDQFBuZWzzAsljvCqL+9KwMzLYoeWwXRok+Les1Wzvten1bmIVGYZwNhK3X+/XpFusw+BPGgDv5FYoJ/yboQggT4/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQYPR01MB11558

> Can a constrained task whose dl_deadline is increased to equal dl_period
> during an active period still bypass throttling in the gap between its
> current deadline and its next period?

Yes. We answered "not a bug" on v9: with period_start kept, it is one.
In v11, sched_setattr() will keep the end of a period in progress, and
move its deadline to period_start plus the new dl_deadline. A new case,
deadline_widened_asleep, will test it. In testing without the fix, the
task got 10ms in its period instead of the 2ms it had left.

> Does advancing dl_se->deadline by period here keep the old relative
> deadline offset across future periods after sched_setattr() changes
> dl_deadline? 

Yes. This patch introduced it: v7.4-rc2 shifted the period instead. v11
will set the deadline to period_start plus dl_deadline when the loop
runs, for an entity that is not boosted. A new case,
deadline_grows_running, will test it. In testing without the fix, the
task ran 69ms after its wakeup.

The same change covers a shorter dl_period while the task is
throttled. The refill would otherwise print "sched: DL
replenish lagged too much". A new case, period_shrunk_throttled, will
test it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

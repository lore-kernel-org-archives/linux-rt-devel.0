Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794150548;
	b=tzYLnuNgywEFyp69Kz4jcgcqZZjYf80ZK+FdRQMwzrcUrTBzKYzywuP6WrmvEYjpId+S
	 Z/3sWoMk2nNE7VRWlrdnDE9djC64ZrZEINxxJEWmUta2vR1BiXzU9S7tmfTgFd5eP1m0V
	 2lkegJDXM0mq09o4SdRKCKtOXEvNV624u7Uxcd8wYfE4q4hDBrYIj1ReyMBFTFzpxdn5Y
	 X0nkBIuC5LJpsqXHFXU1RC6nqgB1N4cQrB/gMYXI9NIV4PwSbrXJynaIE5S1PPuPuO4Rv
	 seYhlHOK74qPVXeErk1yBTzG4lzgBzpzYF+lc15oF1uuzbT+DNmU7RA6VmVnmA9J3PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150548;
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
	bh=sY6tTJ5LDZTcJEy5BuYj+UmghWn8AMnFDfJujy5EkKs=;
	b=CHL5jqPcZmGmX17gnQJ+p8YqY7CJ88SY3PDp1eHX3475XsL/xDWZULNJTmugY/O6CfHS
	 QxhDzh23CU044ntDG5LtUJB5627ESrehZhsyVdcsg+vv0U0IHkqLScZ3kX5KTg86ZsxW6
	 gsQmBHuOH9gM/VM5I47kV0Aw/gRO1xS+a36qgZ39ID2I7TV6DkhP+76AFb2dViy+3Y8bN
	 BHgvey7uspvUrCPZjw3FOKxf00a80LqgfjuwbDg7QQPErwJiCgEDTMBjdf860qyGH1lHA
	 kDFoXk2KIpkVx8ryi+/GmYMAnT223gM6vFnBCzhc6m3Zuf4K7UVZQckwwasfprEZ25g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=lxE3rQg9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.105
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022105.outbound.protection.outlook.com [40.107.193.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03D606A320;
	Sun,  8 Nov 2026 15:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E03D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=lxE3rQg9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/cosg8S1cN/Rxaa7LDF3zLO+iy9AMVvdST+6oPbbzosD6OW9xTk5DAe09szktb6jI9YpkeOwYOx4fJfYw6J0vj4mQjnoi1OQ4qLOVwRGcBPSlDGEkTCFpJgscKVAYXf2ojaX4/Z0EifjnqgEhym1pOetZZqVHqqwQiNUEN7nllV9GRhsMqGfKivzmMMRkMfIc65uRjhZ0Z519X7WiG67RrwNza9rMAgSJUGqGDDBNgos7JSbU2CJtQXi/JQg58xA+j2EDQ+TO1oP0QhzzdtziUzgQ8NVD8aXWvV5PdHA1LobaPhHX8AlSXHT+trcM8O4vkqe/Gpz3aVtpHjbxBnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY6tTJ5LDZTcJEy5BuYj+UmghWn8AMnFDfJujy5EkKs=;
 b=fWJkW6eGlF1BprCZjpoF4idRlBIr/y0XS9VgON85jzo3qlJziik7PSxhB5EsZS++VcFHFhtLJHctItG98u94c9Qpnd0trXrg4WFEXQiTFi8uuEGWImUv4elOQLnwPu+YYs03zjgJsWmCqgI2zceOOBRVUjmu9osGW6+zZYf750yxukDLUraJSNCqgiJctSFcYJy9z7VOzOTo0pyLXSOghmhHDH4RqrpTxR664XAQEEWNJwjJ+OZdmw2eG3THhBjx6FoPSSlnf25UlqLY2lZUCBJMs5Sxx/PpZCxhAZl3yN7uYNgOkaBmx2qFNUpQV40zrmcQtXeq6IftuykDrMstiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY6tTJ5LDZTcJEy5BuYj+UmghWn8AMnFDfJujy5EkKs=;
 b=lxE3rQg9K4MZ2N1JNqF2jEubnjOkoheJcWl7DB/LwiFxdZ8cn/UabE7MPPQ0Daxmr+ftJGbImfSi4gOxx8vZ7MZuNfznoqnKAtGIRhYNbB8wHqm6+3j9SFMTlnl7PmxZUJXSkrAGRPRLkT+qOkPIPdznGdROo7nV4cEA9ILDK5DWBbTwhkNsLMYVKITctkAK+w3Uhe/NQEKSbBtr5/YbhJRzqLurSGYefLvzTjz0Uu2HgFy1lMs/gyj6gGyLqwChUtdSSoy9pNYH3jBeaDQcq2u5GnH/7k2xiOH7I2Z0TkzQ3lZ1HGpRo2/HmXXiT+1Um1Ezge4Aa3Q3s12IAMR2qA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB373984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:cb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 15:09:06 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 15:09:06 +0000
Message-ID: <c757bfb8-0eb4-44d6-85e8-42040dfd1d41@efficios.com>
Date: Sun, 8 Nov 2026 10:09:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/26] sched/deadline: Leave a dying task out of a
 rebuild of the accounting
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-16-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202482@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-202482@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::26) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB373984:EE_
X-MS-Office365-Filtering-Correlation-Id: b7341d00-a87b-445c-5e61-08df3daa3b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jze1Y/bDKDOBbv34Faa5YohQztPNDW/wWCbWtO82V1bV8vc4Z6SrxeahejZ8NAZxJEhYXqTwiD2D2nhqEziCWBHz5BZ8IDPlYBEYloIdEXOYOg9nBah1NYavJ++BCa8Vu2AnwoEsIXzzArj+EPxbtLZELkiFxhyShJ3aePREkWdVlAF+6XNd/zadQtDROzQlVSV4lixI1ArmfNjruMgUdYdyHdGSFsfpg8f9T0QRFGVsKsTXsluVP4nGzDwAKwsgUvd5qbuQALUijRKfG05VFyAV+SxC/lSwjApU2QoamFvjntahawHj5f4cKDszmHofN7dYhDVnfh2gAMCNnzug/Df2guba+DjIpsvskRD3t2eMcT3lZEuXP97hrfwK1754sLrFyzJmNn4ycUphDl35OYbtCHyWu+Hgf30xFVWuKcWFxKGQ6kUSTXx1E4rd05kqlx5y61hYQKJc8v6q70MTrZAYzfq3yMpFGJ2UEtK/oFAWJtgpjcDEPzD+YeqxSyb6ksCR+6lqqp9V1Wdy5RkhdiHEth/fRw7DWsoi/cKCBcK9QEQ8A2/Aa1HDbl3nFm/ZMoMxi2aox1oo64Uf+HMb8KZw2XXzpQWPIzvjR3KTbTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MC9ncDd5cTAxeXVnOE1lWjRhMVBhTDdQd1BsVHNLV1I2M3o3OWE2NC9GOElX?=
 =?utf-8?B?VUp6azhyT3dtUjZxSVRBSDdVeTlPSW9laGtjQkp3VDl1QUxYdTFiclVHUEph?=
 =?utf-8?B?N21aa3ZSWEtMaW42S1lCR08vc0gzcDJmUlZEVHpBVHJBT3dJOFQ3YkhMdjNt?=
 =?utf-8?B?NFNSZk1JdnhNKzk3K093Yi9qb0puMGRveDdmcHJUZktyZjZEVlJRdGR0aFk1?=
 =?utf-8?B?cnhTM2c0bFNSVVNzQjNRUTBDYy9WNVpkR1grZExWdEZXbmswdGNody91aTJX?=
 =?utf-8?B?MTlKd2dpWnRiS0w3bVltSUlmZlB1a3hxZi82WU5UK2JTYkRlUW1JcVVLVzhY?=
 =?utf-8?B?aHJGME1RRk9MYnJETTl4RDFpelQ5dG85dlFOYWtINHZmVjJHSS8rQkJFbUFx?=
 =?utf-8?B?QnluT0dPL0hFYkxrVFlzZitpemVWdGYxUE9PQm9OMzFQVVN4OWdQS3lEbmNV?=
 =?utf-8?B?bDlsVnJ5alpBZHRrYmgxaktPbHNaV0VJbjdpcFlNZlVjNVJsdi9uMHcxSzFV?=
 =?utf-8?B?Q2VCK3FXdXppcmtabEhtMmxPRDAxRDk0N01SdU1lUUxOUDVPcDZRbVFvVWM1?=
 =?utf-8?B?UC9OY1NNQWhhcXBRS29nQmlUdm9mMjc3QktFKzFjcEVnejFUK2tSQ3kxdFpM?=
 =?utf-8?B?QXh1Vmp4eGVUUE9XSGFCbVJQdTdSUFRnRmhiMk9TR25iRjZyMkdmMEFWOG5P?=
 =?utf-8?B?U2hYZlU4ZEhTTjhKVllWdjliQ0lwYmZwMnVRQ0JTRks4cWZ1d09ETDhQeDM2?=
 =?utf-8?B?ZWUzQW1pMG0yeUFVdjdDSUsrR0djbjVHSVoyYllkUUNCQ0E1RmVrN1IrT3FM?=
 =?utf-8?B?VEl3UCtXZ1NJL052STRGSmUvbjZVTi9vVkJXOFBQYXBNTW45VjNBQlpPNmtY?=
 =?utf-8?B?SEFhRTFDTWczQTBJemQzZUh4eWdScnlrbDdEZGhCZnRGWnF0ZVgvOWpUUGU2?=
 =?utf-8?B?VmRUaTBaREFhVVlqQTNENUpSa3FvSUFmUUlwUEVDOHBDalRmV2NjYmI0ejI5?=
 =?utf-8?B?QkkrSm5OeVpobzJJRkNtdjJ5SzBNMGk2cldSU2VqcGVESGpQWFREVGd4L2xI?=
 =?utf-8?B?bUlJV0kxLzBaM2tBL1NIM0szTTBQMVBxcThQZjhEODdlVmZCTGR0T2tFNE9M?=
 =?utf-8?B?b1JqRnYzZjhLaGpzY1E4QUFENDNlaXRYNVQySkVCZ2tveWgrRUk3V0FzdHhO?=
 =?utf-8?B?bThLZllvMHk4Y2c2aU40dGlVRDlyY1c2SWpreWVYWVpTejd6QmRJS0ZLS3Vs?=
 =?utf-8?B?cm52R3lkd3I3SyswSWkrVnpHSkZ0RDlWL011SVg3Zk1DSkFzRS9haG9vN2kx?=
 =?utf-8?B?K3czRmwveXV6TkJLcXJsazc5MFZ4VzJNZWNHOGVIVjFLQ1NYeWVZM09KK3N1?=
 =?utf-8?B?Mlp2d0Z6RERlak4vdktSSWtDR3I1emtnaEgrMWlDbkpmR0dmTnQ5Wkx2L29U?=
 =?utf-8?B?RnFMbFRBczNTMlJ3ZFZ6Z1VhM1FXQTVmdjUwaGt6T00xelkrRHhGQXcxNlhD?=
 =?utf-8?B?cXpXLy9BaTZPSGlad3lpcjRjbnQ3dUQ4emVLOVpkVGU2UTZ5MDQwNy9EdEFO?=
 =?utf-8?B?dmRKZTI4RDlqYWYveCtlZlJKZWt5dFV1c2RxMWtaTWRQM3V6cEc5WDBFdFFP?=
 =?utf-8?B?S3QzNWJMWVRvTUdCZG14UXMvU2JCT1RWMExYbTZYMFI3dVFnWUw5ejVLM2g3?=
 =?utf-8?B?dVdtc1ZoY00zcFo4Uzg5clJWd1RYTVlTYldNR0hRRHZuaGhDb0txZTVMSHV3?=
 =?utf-8?B?TmxTb3JKbFlsRVp1cllEV0hBd2VDaUJpc0R2QWtYM0VxM0JkaVdEei9TOEFQ?=
 =?utf-8?B?L0hRN08xR0lZc0VIT2hhS3p5NFA0M2pRSE9GMkZHc0JYSzh6L1Bod3VzZFBp?=
 =?utf-8?B?Q21QSnNpM2hVNG9wSDVZajVMS3FJRTRiMkpBVW5OVUtuelFtUVRaZXdYaGlP?=
 =?utf-8?B?UFBrNGZNT0RwS3JPSW84aEl2cDErUEMyNUdWSHcwd3VNOVJDNEV4OVFrQi9R?=
 =?utf-8?B?OHRiR2ZORkpJNkRzYlZ6Z1duSGRXTU9zb3NmbklkZVJSK3cxdEczb29PcFFi?=
 =?utf-8?B?bnFjZE9Ybm1qeHJXbDBCRnVrUVA0cjJVbTM4dHM5WkVyRVJ1dzZxdG1GWVBZ?=
 =?utf-8?B?Wkt0MlJqbklRU0YydWpNNDJTeTJ2V2pIMlArWnZVdi81UVNQbzZFb0JBdGNa?=
 =?utf-8?B?c05Qc2pWT1ZLd0Z6RCtzR0ZzY28yQ0dLaDR3MGlKR2lSVUtlK1pDdWFvWits?=
 =?utf-8?B?Wk56K1JTZUV5VWV1SWxObWdCcitUc3FBYVRsZEJzT2pwYVpEMXNyb3FOR05q?=
 =?utf-8?B?dWN3cXpmMzZlMDdjZkdmRitCS0pncUxjVThWTnhZaDUrdUF6QlNReFF6NDRZ?=
 =?utf-8?Q?e5llRPD1Opd3AzmA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7341d00-a87b-445c-5e61-08df3daa3b79
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 15:09:06.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pHktA3ZBoPnk+SDGpuKCa5FmlX5QxzaU9w0KLLXrTeNirWFHcBo+WzqYnZiNvjJOtgyaEd7bv/0BfEgvYbYJOae8z1q3G7NNGbjg0auDj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB373984

On 2026-11-06 21:10, sashiko-bot@kernel.org wrote:
 > premature bandwidth drop in dl_add_task_root_domain()

Right. v5 moves this patch after "Record the root domain holding a
task's bandwidth". The release clears that record under the lock the
walk holds. So the walk leaves out only a dead task with no record, and
counts a dead task that has not reached its last schedule.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

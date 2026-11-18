Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022999;
	b=bhtFrqDTd730dD0JS5X0ZT5NFrFDJjraGlJu4gEIAdkTSJ7cPhzmS/xIdYPsShTPX6ZA
	 BZ7jwUaZV6Mce9ga68dJgL00KcJER5jXEIStYcr7gnJFeRwk4lRNKPCb/dhkvLgr9SivA
	 hh/KMzOZIsyxoXSV18WeZhKm6chWNPJ6YjWMmHv3OaXFzOzAnXgTTqgOaxT0yJm0qAMZj
	 upuO+T2Cob+Wvp6kf3CfmZeSJxOQfqNlEoeSOgfA3s45bWbODk7Q6UAnJe7ZlYAIZny+d
	 /rKbYAtdjOiOB+2MCA1a0vSD2lHGupF4yPuxMhvQnhADXit8vSj6aJgl+4R9pCTQuMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022999;
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
	bh=JnXUzxCQC1yDqwu2E0NYc6l4pXoj+t9j6grsx26mUlI=;
	b=Yi224Yvkaqs2dvlqi5B8kZWAPwYU05vhy5I0ZIf0dxvehXFk9zg+zVsKs4ekqQaN1p4E
	 FLFEJSOmus347uo2uhU/XW/R6yZ7R2zjJZJDuWSPB6nVQDNU9h3mUeoGFrxctTvbi9bXi
	 1rEK7FAunl5mSKgq+qAze/dRMxIXQCDejxzcEXdyjqIevN2NYqyqe55qICovUatZlYvXm
	 P9FKE95MrR1KEDsYYHsP2cBBNAI6nTeuKVyvxRdqurKK7WrQde+Rg8B250Gm+4wqBnihM
	 HGtdNxfoq+KvfIcrWX7VmkdE1AIszVqltb70aTpMffX3dFIOgCPtejTURcB2PG4y8+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=MS8rnmc4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.129
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022129.outbound.protection.outlook.com [40.107.193.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1E606A320
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 17:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BA1E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=MS8rnmc4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLn+xJ4qCfEIQlNLjD+QnfABeWRmVh8ILt7czFGuk9NQg6PUA8VxrFColKaEgafAu4bFojYq/QUoKLPog1R5G2esBQmXiFd7ur3gdM6hOpFSfIMEOGEquWqKLstyNn2CifneKMN4RNLJ5CQURbqMuH6/x7KYHyKqR3vARHo1ygCUzTsCF2oMTAClBIqhw8VuS90rHp4LovCmXyQ9l9A5q6YgXGkEEH4HZip04QaBLbxp9ad3K8WThno5JI2hIGwMDy82vy9CcuKFKmudJdp8eGSZqQj61LYoDh9NMEElWtyRl4whcC9JNqkqgXHQ4p/07Wj5v+usJpudeUr7QjGCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnXUzxCQC1yDqwu2E0NYc6l4pXoj+t9j6grsx26mUlI=;
 b=p5Rl0gUxkubo52iYuTKACjKreYGq3k2eRKkDWGE4z6ajsf4mLZtlJILPm2bRphNy4tkmcP/Ot/9njdO1j0m4CQhwI+FS0CvNw+qPu70Ed5Uhrq/oCd27lSjsFeiwqzIQWaz5ieXIyJCmYx+EFaTyIDNviUinJ2hrsMuFOmRIZVtlpAebr6pgzdHDu9xQP4xe8e3dzFDqppl2FdP/TC5Q+076Y3Ve/o07fydFCBQMqL5qR4PTGHXDb/EgJsCI7V+oYOhRrV5MdpiKYeJ9Ws9QDHd6kQqMezldYWkoKSw85dumI5NdQl0MY1+PE63IntI6FQvsU6dzS/bE9kUJtrzBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnXUzxCQC1yDqwu2E0NYc6l4pXoj+t9j6grsx26mUlI=;
 b=MS8rnmc4FAFKwBRE6ixZaYeT6amhCvaA+H986Q8O8v72SMJYZcEvdWLZmQVo9DzaNWpt6uB1xgFvfwmek3/ZUk6bqf8h4IrR5fopwMvgprh96TMR04WJoVBTQ9fyZv+XDU7lqxYTnODZFatJ6isnOGeRxmWb3XIp/FzxPI3esHzuTjtlhFCy6pv9FNQyOrwPe1/xHRiGKPxhuKVVtGZ4u7ZLw69LpaBNf2Q1zxB5b13Iv5xOy6+L8rNewv1C9AStbFgy3Dm7Hhm7sG/+/1+BT8n0qVtSe0sWSznY16Vlt08tUYq+I5ps0gv9c/syAhPv4ytflcEUBY8TQ8OR0Z1LNw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB11553.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:154::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:29:56 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:29:56 +0000
Message-ID: <e57bdae9-4f87-4cc1-9fdc-22c2d766e252@efficios.com>
Date: Wed, 18 Nov 2026 12:29:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] locking/ww_mutex/test: Time an ABBA with both
 owners running
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
 longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 shuah@kernel.org, juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-6-mathieu.desnoyers@efficios.com>
 <20261118163807.75hxTxGn@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261118163807.75hxTxGn@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::19) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB11553:EE_
X-MS-Office365-Filtering-Correlation-Id: 138bdd44-3f05-44f8-7644-08df4599903f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|261026140227099003|4143699003|56012099006|261026121527099003|261022075727099003|261022105027099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HrzOh5BUU1pL1W9CRkpiKbA0Yq3tmxL4uOa1Psp0BouBh5kMaWvfkvabai0WXej1Zl979ZOERg7PFBedvj1L304xhnpyxQ6n5DBzOc8MUO6aFZSWwgcM7ET/HkoQKWJ3pOynCri48NBmIcTLGooK+kkdE/XECHU9r7SU9IquyiZnvC/kMpfckb3v9vfKlxhLn7LdojOeCYWmIPZFG8tUmVx8xHOZzfpn8NZzHg5DTnMy9NskeuBhqpzC9A7f5AEFEzcjq7uTGZrfLgWsjbmkcXokmW35n43r4y0eXVAwhoCW986EhtcyJc/4yoDFSmGw3kyCAHfpftcMDs6VTsO2J2kDaCucEd3bgfcdKl0vFXMn0cFJyChDeQrhNMl7fwUvdzMtK1TTo9N4MjjCxcTER4hZC1xD3KzCcA83nsNQ5Gmt/b6n++LEtKSTx8AfGfadvFzkNflWIQiA9n3RLI7qdaNdfBR5RdzHuNpsxdzJVeE91hkSUIhG+w/yj8Ag4RBwfTMJ+eYAjOnqQPcEZpEHbVdMqN2Kr6Z6exdz+igqbIWh1S89+7MeWwVfeC15stPDFaEbfNslo5z9sQKbLQVJ9msQLZpUdaWdzGegwqfLT2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(261026140227099003)(4143699003)(56012099006)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3R5UTlPeUlHVHNGTDcxNHVySERQV3lJWmpvWGliakJmRnBraWZOT1V6R1Jh?=
 =?utf-8?B?TlhBRnlveFhOeS9PdHpUTVl1NUxjVU1kTjYrR05lVlpJTFNjY2daTzhnWlhu?=
 =?utf-8?B?OUxWdnRYVUJmdWJZK2MyMkxTU1dObmZWQjI5UFRqZXBZekdabnJJdXkvbmJO?=
 =?utf-8?B?SG5SR2RzRlpwMGN3QUJYKzBMdFJkejJ5K0I5SW1RWnpqZ24vRGlEMnNhVmpt?=
 =?utf-8?B?aDlRemVXRlRxUFBiT2NnNlNlKzYvQlZLcCttb0hkR1Vxc2ZWakp1b0RJWFA4?=
 =?utf-8?B?U3BTb1p1QURCazduMHJwbUFKZTJjZHd6azlXZFFiMzBMMzVWV2xsOFpkRlFM?=
 =?utf-8?B?WlJtdVF3RkQyTUxjVExlbS9JaTZTRWozQlBkZ0l6bFRXVmx0V2FwK3JmclZN?=
 =?utf-8?B?UjZUVFltYzNNQnJJWTV0ck53WnlBeVFVQmVCanVnRHJQeTRaanFRaFIyYS9S?=
 =?utf-8?B?NXNZQkwxNXU5aFNkQStFYm1vc2hrM084UVBEMVdsdUsyODBkTEh1L0Q0MFRO?=
 =?utf-8?B?aUlFOU1HZU80bUhWQWVGbEsyVisxZm9NVWgyYzVGZ094R0RnS1ZST1FCY0Rn?=
 =?utf-8?B?UlduR0dHdUgrMnhQM2hycDBBaGNPaUN5TSswOGI1aGU0d3JHZmJTMlQ3ejJr?=
 =?utf-8?B?K0VjeU9IRDA0QUV4aE10VEMrbTB5SjRNd0t0NGpKNUpLVlZ4enkrRzd6cGlm?=
 =?utf-8?B?MzFSYmEyS1VrbVFtRTNiT2xac2c2MU5PdDFTc1pWYmJYR2VlZWgxMzRWT1Vq?=
 =?utf-8?B?ZlhhT1d6T1oyOFBJSlVxYWFtb1pMTnZzcXVQcXkwWDVMa3ZjOC9qNzhoYkE2?=
 =?utf-8?B?SURtVCtleWN0M3Iveit5dG5BMTdPVzVRRkhzNEdBdzd5Mk9LVDY4MlJBSEQ1?=
 =?utf-8?B?QVRXc21tS3VPQURnVzVyNjlhcUR5d2pyZjBzbUErNFBRN2NnYm5Da2NNNjlC?=
 =?utf-8?B?OUR2THJLdnFYNUNIUUo5RElGNm5ZM0RqbXVvZkFNZjh3QkpCS1F0Q1BpeHNn?=
 =?utf-8?B?MkVsa0EzOUdCNTFyTmY3U1R3Y0t3bnpJN3F5YytybG5OQnRZZm9QZnJKT1ZF?=
 =?utf-8?B?SlB5bWhuNVlBYTk3dW44YzFDdHNlek9Wdll1RzFRbjZrNk53Uy8rMXRRU1JS?=
 =?utf-8?B?Rk5sdlg0dGtwRW04d1FCNGxJTGpCbUtMb2ZSeUEybDZjc01qZVNDck9iWGxh?=
 =?utf-8?B?WUI4c0pWdWUyQ2RVbjhkT3VPOHJJdkZNY2lIbnpKdFNxNnBzZ1VCamUxK1Nl?=
 =?utf-8?B?SHp1bm02MXdlODY3aGNMakJQTHY3d1pUZ2dDRzh6Mkk0UTJJaWtXUE10cGxp?=
 =?utf-8?B?eEcxNzAvcitlNzI4VUVWL0xDblZnNDN5S3ZwUkswdXE5VmoxclFoODIrZDQ0?=
 =?utf-8?B?WnEybERGenhsRVZSTlZFN3NEaU1PWHdCNjd0VXkxZVhzRG5Ua3VRcFlHT2Y4?=
 =?utf-8?B?dmhuSXh4dzhtaTVOR0wwTE9pNVBIKzhlOUF2YkhBY3ljS3YxUTFTK3FLNCtB?=
 =?utf-8?B?aGlGcFJRcGpkYUU3cERZc1dLR1N0elJEMm05MXREcnh4aWlaV3UwTTVGQzQr?=
 =?utf-8?B?YkNMOUZzVFQ4SXp1eHVYc3lUbURIVkpya0hJcVFDVElrb29LWEJFeEpJQ2pI?=
 =?utf-8?B?T1F0M0xEMGd2VDU4WllKY3c5RENMdW02VU5wdndHWitHbUp2bG91QXlOUVlE?=
 =?utf-8?B?OU5uaGxTWkRvdkZUb3MydTQzc0xJdnBTTVRjY0VsTUQvWDFhUVF6TXlnYm14?=
 =?utf-8?B?SnhCWlAxeFNib2wvYnVWeUduN0pFZklYU3VyZGdwaFJyWDNjdzBLZzdnSzMw?=
 =?utf-8?B?c3JyZmFnN0UrZHErai82NDJoYXcvSC9XdG9ZMy9rZnZGVmJDUkhEbTBlT2Va?=
 =?utf-8?B?ZVJhTjc1U25LRnBhV1JDdU1COGQ2Y0Nvem9QK2tHaGRmK2h6VjNsbTA1RnRw?=
 =?utf-8?B?ZnBTb2J0c0dDR3BFUVVHZmtlUXRab1A3cjd6S0JiUS9aOEFuNDBVWk5NcDlh?=
 =?utf-8?B?NkdTYXJEeXFyY2ZTTlNZNGd1UGd2VktYVFN4K1llN1BnTjBNZWFLaUh2Snk4?=
 =?utf-8?B?UmVMdWJOUnJYRU5NUEJPWTdpTExGenVaUCsydUtlQ3ZhZEROMFltYzJUSnk3?=
 =?utf-8?B?c0dVTTFJclFXZk1nNnMra2hyOWpFRHdFa2RjbHVDY01ta1lmeHg3OVE5U01E?=
 =?utf-8?B?Ylhjc3l3WUdWdjFvd2RIZHJBQlRiaENTcGhmMjdoeHp6MjZEb3haTC9DYmNs?=
 =?utf-8?B?NG5ReDdTSGwrWjUzcTR5djU3VFBHbExMeUJsbWpvZ3BwYjhhcVNlbVMzQ1Ni?=
 =?utf-8?B?Y3l6K2V1cytKL2tnN21hSU55cnFyZDBNUVRyQVJGeUE4NWlsNUVyTk9WdXll?=
 =?utf-8?Q?ijSDf/Yi0Q7erZywccCww8WxJBAB5Q0I3iMSw?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138bdd44-3f05-44f8-7644-08df4599903f
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:29:56.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8zSuqqyuK6gZ1diOmEc9AVOCuZ57P8vJFX7WkuXpqR72/dlZ/V4nJyR29XpSeMkroY9TeZN/3LGad1G7rh4QdNPC6/AKwyLe8wu+L3Z24c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11553

Hi Sebastian,

> This is the ww_mutex equivalent of the futex case on PREEMPT_RT. I got
> lightly distracted by the -35/-EDEADLK error it always returns.
> Something that we might have since v5.16-rc1…

Where do you see it? In this case, the younger context gets -EDEADLK
from ww_mutex_lock(A). That is the wound: it backs off and retries, and
the case returns 0. In our PREEMPT_RT VMs, test-ww_mutex loads with 0.
If a case of the module returns -35 on your setup, I can look into it.
Which case prints it?

> Since both (ww-mutex and futex) use the same code I am tempted to say
> that one test case might be enough.

The two take different wakeups through the same spin. A timeout or a
signal wakes the futex waiter, and its cases fail with and without
PREEMPT_RT. The wound wakes this one, and it fails only with
PREEMPT_RT. I would keep it, but I can drop it if you prefer.

> But in case we want this,
> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

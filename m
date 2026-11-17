Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925095;
	b=fW8IBWkepigdvKxkP+BCil9i3NTYUdx2lzFjSSWFsYnrTnPH6KtvXASai9A7zrj3dDhL
	 qFsI51SRu2vL2peXCJ0azRrZSWLBZR75yv4N380G/YXpNO7G3uJ6K0KsVfsbRtYsDO1Mj
	 3MXjixVqCXz6nWY6obfNFufYPUiTMHdoF/HuQok5brxGAtMSqIZkQb+mVJ/wVViROloNv
	 j7/jHA3TLBsOv8LJnoM8wPULBMesCxfyjGJuRqq3zHRPM+uykB1qf5OMXPQwzLqCS1HGU
	 bpVLdvufOOPxGaLrQSCzkZBWuiuCN1p2+NpALTq+TDj8I1F6IB8rLdDnqkE5i+S8HOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925095;
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
	bh=6Ifg/xKByGy41XqMsEtzZbdP0yXlHMiTR3YnPv0BimU=;
	b=RbGi3e7EDp8XpCKJd16aYV5tUCRZWaTC/2+rH3lqKbMistoLQRfKK6PBtpeewr5tcilT
	 wHUUPTr6CcOr5wshvPWHsHAxvdtYdhzu5VJ1ki8dP7Q/a1FFTsUAemq80noJu8Ude3AO6
	 zrPj87GZrt7/BgBzh7lO4Lt0kn3kMv0K3cj6nwmDnTztvxSKguYDUgSezo11MGA3gMFJ/
	 3BDqy+F1R0loboibL9mi3j0phInZesOi77F804pxwt67uvp7rapt6QcXQNFRoB8dLl/Gz
	 SoYo/zN8+TfQOxcWMzO8A2l7g3FQbHG7lGO6TqkgIBuy+8SkRlYeGnJl2kKt4ImiGEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=NPO6Knqo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.139
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022139.outbound.protection.outlook.com [40.107.193.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A00606A32F;
	Tue, 17 Nov 2026 14:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A00606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=NPO6Knqo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zC6LygWfbSCYDyd6GnQ2BTau4co3iTCOzMyjoJ+OFmi3exBxp/+0i8+FGyf8IvlYRVEi2W/fwztM5QAD8jed8fD6l0RQu9UGBCrkh7zgXajANrp1C0PWoc1ARZ1iTErmwGXs6C+RMIkdgl8CZlONLjkG7oHITG6lW73NWLdLSusxu1SpzAC5Of8a1Ae0n1kvMVgKmxB5pUE6pgOUNideHU5SWEEFTqpDaigGcuTxQykgNGjHmPGV5F8M9ywAFJcSxhWJ+naUP0LcFAORbTHQNWDIcAobQ0t7/Ecb4NXAPv3HFx62uVIhZ4MLwX1X6bl3OzFGMjPV112c4jxT9+90jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ifg/xKByGy41XqMsEtzZbdP0yXlHMiTR3YnPv0BimU=;
 b=T5BHuoYPZUjEwiZPWevd/KnmIBF20u1AdTIGNole188TwyVVN7jOTcewb0eRFbGBirLe3RJccCv3YM5pCBlEKxRWDm1REXawzalDvOmnkaXiC0awofUBtpQsv9rTmWrrBvCgE7yemPLvpF8ngh9TPbtLyWZhT6o2x13b4J54H5G0R6JtMI0y2chy3b3+dGbCLp1z/C4RHVb6UukLldIuuu5o5ifzO/e/S+W1P8/nkQHNTIMKP4zifXMO1GORgmpX5Kc3c9O76JN4JM67bRO+J8Vtstn8Xs0+Vm15++U+0bYnPuCeJZ6WBDwCTHiGl4byDdO3wg6D4kv6PODDboS74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ifg/xKByGy41XqMsEtzZbdP0yXlHMiTR3YnPv0BimU=;
 b=NPO6Knqobw4BmQjl3gDeNfGXuhS25oxmkUgw7/5IS5lcLDZjjDtO4ycCSGV6dJdnEJHJnxktA+rGib0DFMNaWWwIf9SVsgCNwpbJnqUJmCByV4HbVqJye/w5i7KOrCXbqn4nAZJrTaQXycQCh6vJ5jerGjTv7p9IYYHNGSkxtI7adLFZaCi1I9iV/ynv0ZA6mPj9po/tK21C9TP1uz+slQhkgaub4ULCcGWH0ltBqpfOx3Bd8xeNrf/awMhIp9RgzFYWEPOAabDazoqT4yWVhPXAQa+cFnr5eLbqba/bRtQY0cZflB74Zub8VKtWPOexWqCP7IFClriLeHkXDnzhqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB9297.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:18:11 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:18:11 +0000
Message-ID: <a2c1a3c4-92c2-4ce5-a553-9f6345a1d090@efficios.com>
Date: Tue, 17 Nov 2026 09:18:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 31/37] sched/deadline: Start a period for a task that
 enters the class blocked
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-32-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-217639@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-217639@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::12) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: 289ca596-102a-46c4-19d6-08df44b59c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|3023799007|4143699003|56012099006|5023799004|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	AlPuEEdsTkprlYDv2vweCz04f4glzAWtnmf9DJjlFd+uA/I56xX9RLtRyGeXFYN29HG6bwuRQzxWW8VlkeBETxc9xiyWqHHjZrraLmHZc7fWR4xXMIruAkNYxuWNWOmBrW4l72J+Hh7l3rd4K9el2h242x6tYxiLO8FMB+Df2aRSfj5lj3gtqQwIxb8YNqVOLUCYkH2NUqecWuP8D92ntQIF2ZSug11bdT8mRCQL7QriuPl6Kn3Lx89AdQ4avK9806L77u0+eRiWo+JmZy+QbFpo9JEEvhAudKAey1U/3BSK7PLvRNREdOoIJgKT+qidYGmpGT3f2jSr94m26/Ok/Wuc+I/7uGDBFe8eAXeVYTkJMRnjlxjG69sccx11ZXSE7AQAzi/VssX2I8RxrydS9Dix1+ZyCmmhzExF7tSe7q9nDETOHL7cw9JBW+DQIBfC43N8iGX8oSxJtes5X+DyQM3OLsuuAo/duguJTPGKbjqJO4dSm6crgc5/3d0e31ZDtgpZLxfU0mPPjC//LBklSFGVM2WodmoYWR4w0lsJRJ+/vd6aKZponwLmu72gWg8DF1WrhOf9LIQkDfhPbxxGpckLsnQmgWg2aPzvTrcWTk0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(5023799004)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXJMSkR4ZHBQRzJmZkdDTkNmZGxrZEVXSktoMW1ibTViZzBscWxYaEt2NU1Q?=
 =?utf-8?B?a3BOWGMvYXJ1cFJxa2gvWGk1V2dQSHFjNUJBZ0lQQVdIaWhQMWxIZVd6ZkV1?=
 =?utf-8?B?eXFSZWVNWC9zSzlSd3piYjRKS3duUkJOTHovZjBYTk9ZbHlsM0c2cWZGNXNj?=
 =?utf-8?B?YlZ6NTkvUHZVQXErTm14c0thMDdnVnNwSnJVeFg3dGxCR05YR0VSRmpNT1A0?=
 =?utf-8?B?U0d4MG4xcFlCb2xGNjNjYWlUYVlGSTNWN05Ob3VXN0wvZGlROVUrMFJFYWlN?=
 =?utf-8?B?enNjT3kxK3JiV3ZieTNOaVZxYWdRdThnSjBkYyt4YzBPNWhKMnhjQTdIUXB6?=
 =?utf-8?B?M1kwYjVkQUxiWUZlN25KMUhJN3dzWndJR2c0aldBQjFKeWxjWUZUWURkQUpM?=
 =?utf-8?B?bForQW9YQkRFSVRmcjgyVStZRU1QTk5mTVhtUmcvRmRPQWhHTFRML0lTMlBQ?=
 =?utf-8?B?VitmcjZRUFJsQURZeC84NHA2bDhWSE94anJwdXZaZlpBSVVBSlU5M2x5RU9W?=
 =?utf-8?B?ODJub2Y4WTd6SHNlREFxeW9oZU9nSE1uUStranAxamRidjJubFJLOS8zaHJ2?=
 =?utf-8?B?ZGoyUmhSY3BSU1pRY1VxMlFBdUVrU05UN3dIOFR1Mncrb2dJdGVkTzl3SnQz?=
 =?utf-8?B?TFY0a0JQb3duYUxsTmU3dFpTMVk1dS9IRnJ3N2oyVnR0eW9KSmRuZnJ0dnBV?=
 =?utf-8?B?KzlWdGIxM01NTFJxdmtTN3AzQjdrRVZNVisrTEN5Yzh1d3NWWEpSUnovWDYv?=
 =?utf-8?B?WkhZT2pIeVVXSHZYS1JPRk1rcC9nVDVrd2hESHU3ZzB2cnY4UE1sSlpKOWp3?=
 =?utf-8?B?SFd6NXdHMk1IK2gyMG9aTGlOalhWWDIxWFlWTzJOYm0wdGorZG55RUZMQ3hR?=
 =?utf-8?B?aDVrRDJWOUlaSFZ1S1EwcGxwajAvM0ZYUGRJZU5adVk4R2lvaTFwOENLeU51?=
 =?utf-8?B?V2ZGbnpEbTJXZ1B4UHRIMWdvQ2gxdDV3QXQ5VWhrN1ZHcGdtMVQwcUxnR3lW?=
 =?utf-8?B?UHgwWUdBa042S1cvTTBSYndIUGNvNjlNakVyN004ejBXcWNMY2VoTk9DK083?=
 =?utf-8?B?ajVUTnpicXlUL3FPb2dOd21EdjUxTDZaTTVSZld5R1RHc1R5bmxVc1ViRGZo?=
 =?utf-8?B?SjZHNnJVaHdraThTSklIazNudlZDd05aWk51ejR5c0hsUFFtRXMydFo1YWt3?=
 =?utf-8?B?RWloc2hMSi9YNWFnNldpL1JhQjB2TGNFUytvMWx0SGh5RG9WWmwwNWxUMVda?=
 =?utf-8?B?eE4rS3ZZMUc1OVgvQ2JoOWoxeEphZmNLMFZ0aDZDUXF3MEhOcEo1dVk3d2RK?=
 =?utf-8?B?OHNJUVY1UjJaTmtxSUxZYyt1ZlIwTmdvYU9JNnRINXhBeEE3RDZzQlRhMlEr?=
 =?utf-8?B?STdIbmY2a01BSWtMQndHb2ZuRUVZUVZUb1lFaEQvOWhDZ0RGcWQveW9RYVFQ?=
 =?utf-8?B?dm8rRUFnUUJMek0wVG0xcHZmNXd1bmxNdVdYWlhLb1crb2FUQXp2aXd3ZUNX?=
 =?utf-8?B?Yk9WWlNLaTNqK3lXSGdlT0dwa3pNKzJ6NFRnR24xTWx6OWlLWUpMaU1BVTdu?=
 =?utf-8?B?RkhFYlZlN01oWURjUmZSUldodU5mUGRqY3hReVEwazNIWHpOZ0tROS9PMzdQ?=
 =?utf-8?B?Mm5RYkVnRnZhVlBuNUpLd242VHZ6enVLa1d5NldrWFovSjRyQlZRODV5MldC?=
 =?utf-8?B?MmlFRXVTS3h2R3NVd1ZOZktXS1NRdXVpbWk4OGdpR0RQejNndWZQL1RaZ1VJ?=
 =?utf-8?B?NUZTSy9FZkJFODg4cGJDLzhza0szY2lTNlRCOTg0enpoZnZXb0UrVTBkOGxj?=
 =?utf-8?B?SEI0UnBBN0RZWWpWcytoQXFkQmdSNEtZZ2k3Uy95VExkWUhLN2ZwNTJvR1hw?=
 =?utf-8?B?UVVZTXlKQk9aeDFhbVQvYTJka2tsL29nS0NkSlJmZTlEbmlNVk9icHFMMTEy?=
 =?utf-8?B?dWdkMDI2MDF1dkRMUEJiUndFeHRmbnJYNFo3ZlRVTkZudFpwQTZYdmdSY0oy?=
 =?utf-8?B?cmVEZXNTd015L2hZTmkyNXdtNHQxZ1o3V0tibEZXMDNVTkloYkNxa3VGUWhj?=
 =?utf-8?B?UGJKdjdacnlObVdMSllGTWhFSU9UWVlYVmpyenMwM3BUQzlOSEhqYTliVElH?=
 =?utf-8?B?QmR5d2psU1ZBWEV5dmZGWHk0TVpicDRXQm0zTWgwQUhRYzZ6TlVRNUptQjBK?=
 =?utf-8?B?LytFdmVqd0t6SXNaUVNUWXdYeG1hamV4aVpiZFErS3ZIbjIwdXk5YnlMaEh3?=
 =?utf-8?B?K00ybS9CemZBUEdkMHlRSVRLYjBsdWt4Z21hZnVQQ0liWldYcU1acTBrWUo2?=
 =?utf-8?B?VFJqZ2R4bkZrSDhtUE1WRm9Gc1A5TzJoU0xxcEI2UElMSFUrZEhxeVIxU3gr?=
 =?utf-8?Q?KyuPkLaRGXrIEuIPk4xVeF8CpS159DluP5DRa?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289ca596-102a-46c4-19d6-08df44b59c48
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:18:11.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beiaC54lVQGkvuxGDJojSBE5BXcyxQ8+c5dLUVCPaQsU5c+ksh+GqB3bOjGDcXugxURF+wm6Ch7IBX12KqwAp+S8pwIKw79b0KcMNNTIDfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9297

> Does gating replenish_dl_new_period() on dl_task_pi_blocked(p) leave
> p->dl.deadline at 0 when a sleeping task participates in rt_mutex priority
> inheritance before waking up?

Both cases are real, and upstream. But a deadline of 0 is one case of a
wider behaviour. A deadline task that sleeps keeps the deadline of its
last period. After a long sleep, that deadline is far in the past. It
sorts first at a requeue_pi, and it blocks the boost of a sleeping
owner, as 0 does. This happens with or without a class change.

This patch fixes the case where the task already waits on the rt_mutex
when it enters the class. Refreshing the deadline of a sleeping task in
the rt_mutex paths would be a separate change.

> If p->dl.dl_throttled is still set, switched_to_dl() skips
> replenish_dl_new_period() and leaves p throttled with its expired deadline;
> if p->dl.dl_timer then fires while p is boosted, dl_task_timer() bails out
> on is_dl_boosted(dl_se) without clearing dl_throttled

Right, and upstream. The planned next version has a separate patch for
it: dl_task_timer() replenishes a boosted task that sleeps.

> Even when p is not
> throttled, if its old pre-0-lag p->dl.deadline is still in the future,
> switched_to_dl() skips replenish_dl_new_period() and the chain walk sorts p
> using its abandoned reservation's deadline instead of the donor's.

This is intended. A queued task boosted back keeps its deadline too.
replenish_dl_entity() keeps the deadline and the runtime of a task with
parameters of its own, while it has runtime left. The blocked task now
gets the same. The task keeps its parameters until its 0-lag time, so
that leaving the class and coming back gains nothing.

> Does starting a period in switched_to_dl() leave p->dl.deadline stale if the
> top PI donor on a blocked task changes while it remains in dl_sched_class?

Yes. Fixed in the planned next version: a boost of a blocked task with
no parameters of its own starts a period from the new donor.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

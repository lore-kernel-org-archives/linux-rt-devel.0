Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442420;
	b=ird9sh9p7uhjx42Nts7A4iDIjgfvW2r9cCM313RAcvSQ2g6kbxE1uLQ9XHcjYI5LJfB6
	 leLgbZDdpx+4ZXvgVTILZpHOvs73QDKesDzwYmdqxV5J77N637ino523jCQAV4Nw52c0J
	 1o7DVRBZ7JkRoKLV4zwSULhQztj7tXO5iyzeUdtwd5BzFaLz/lvd75PAMSrgRZ4YNp9LO
	 k70o43Hbnphvm40fUUpMk7FLjUgwwXoQv6CCZYJO/8qWByQ9IGLk7PQgdyHjC5x3/uCc5
	 an8jQXNdWvKlAul7F8oQgKAS7AM6KBl03CQ/ZwV9PJq5PtNV2IMgJnziwUH4cW0eo1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442420;
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
	bh=k8gRMTXw4hDKTvu6l1rW7r2NVIYiKnP95btihjl6N4E=;
	b=BFR5DjtEi26B8JFR8EotBhNbSVVqX2ppIaHxecAXTV66taYjm/MoY8NDILXhzAWD3iNC
	 4HG3IMtZwfVoqNqOVlyLVDmSXJyzbWe48aFtC4kUOw39sBgiRIsNY7/i4iFKO9+nUE0XC
	 sTlKkTzZ/Fddc7Uhz4AVRvUPNerjaBfYPRGiBQovJRdHXoVtG+BbZuuVCurVApm9aHshM
	 1hh79yP/l6z+ejREiUAYIICYxL/a/Oc6uyBpd0H4dhb3G/C7czZlEO6eCcEauQkyMG/CW
	 3A6kdOog13wsAP0HiW2UamFW6enP3Be3FHeyX72vmii4hYjSgY3oAKhmRrmlm520cgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=EXiKv7jz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.122
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020122.outbound.protection.outlook.com [52.101.189.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B5606A334;
	Mon, 23 Nov 2026 14:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F4B5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=EXiKv7jz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deduP5DnoIRfG9rfjnGPbhoW+CcRzfG7iR79fPHf5fCziPtlAqvms8eSlSCb+srmJcuARMN1d8MhXTXsiSXuun4nZuodlvd4t9cpEZNZ418NogB22zcKdeaBIOwq2b9UFmVuCM9uRP89mou/Wnb61li7lkWZQBPb9LbyYitMCtStN7BtO8YJWx7eanRl23Zzl15YeHBW6W8BoyR68glCIuHL9o8r0yHdfgnIvA4TGrAMknGJL5uS7n4BZ8TuncVi86iwSh4f8vvfH9nyjmpPZkqVb9lU/EfmCfD27v97HFtTZJCz0aKu4gXHWeQQV1Nz74/DZlYNibidXBJ7tgMmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8gRMTXw4hDKTvu6l1rW7r2NVIYiKnP95btihjl6N4E=;
 b=RRD4IwRIYKHPfIj0p8ZrkgfMjq+Czc/Ukam7mKL28COGXBkag5RmdAP/1qGsvpHxjJNvzYh94V+UzN6AYZFOaWVQQSXiiMpDj0Y2UKkGOu+gTLvP9gQJub3fzuovge+/DqlBLpTd31ero4JnqC3CpK6W200QTEudBrvazBKfQMw07PB0FFPRq12wmVlXLx4RYXRHqdNe38TDvP8ioQYfasbFUZ35dlWBXCbHBw909Ar92oAyEBiCRGgIcsHW6CiJrdObsIL9cGDZypA0Oux0rhAz+l4xU1/TyJE6dQ4+zu5CLPObQiN8UiurHzfAn5JSX0yZOyuVHVelz3ro66mC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8gRMTXw4hDKTvu6l1rW7r2NVIYiKnP95btihjl6N4E=;
 b=EXiKv7jzBIkLIz882rjMkAl8qNCoJfq6621RfAWYbCSQBxZ86P0lAid7wdeFRYlSyz40EfQ9JROYgQfuB44ZDKO5/fpO2rvuSKjwT4HzD3pEXts2fs5tUo+17W73n7CRKCJdXDpO25vLaJSgDo3Wg7tALEHkImOe8z3DWn984luYiuvKNj8hwDgp0rE3LMzy4gIrPXv1d+PdpMkVowwu2DpwC35MixEPbuSLov1QngCtM3n6uFHq0bTDAqm+FXapiCtilA+ja8WdVtpvpbHGOwP+yQY5Ie9r7IeHL0FsHwGzU0cvNeKE61fSn89PjG+k8AdBxDiF5ZRmbpiHnSa0Yw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQYPR01MB11558.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:a6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 14:00:15 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 14:00:15 +0000
Message-ID: <d9b295a7-f69e-48e7-a095-50d16d58c0f1@efficios.com>
Date: Mon, 23 Nov 2026 09:00:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 28/40] sched/deadline: Start a period for a task that
 enters the class blocked
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <0557a76f35a09f1caa281777e3926d3446a7c74e.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226162@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226162@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: d24797a6-6ce9-43ef-2c1c-08df496a1944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261022105027099003|261026140227099003|261028144727099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	dxPDKvmkJI7EpHe9UkE80DrCvnU3RAA/YXVbteRJ8tzCjGJCQiXjb3UdNigCgxjb1pqUiCARSd1gC/86LnA4evu/M26PfY3jelGp2heN8UYtD6bTzQJnJ5gQwbVIQ1sgw/h2bbooBkb1zJ9Er7m0xRBBtYn+S75SGcoTz/v8l71uKJgh2pYqT/L7ujIujBpXdS5s+F/fRVFQzb9Qy13EvZYvDo+HsPbyFjeszi+aJ5dkIOlQo3EtqMEEE0ay9dix5Vz4yauKNeLtBYLk8gdQu0ljyPy7a5j6dw9VIy7JQoXRpz52J4qjerVd0Gfzq4DZZVBNZJ+tfjuDJF7+dRt5pkEMYwxjVGePVcUVhngsRSNLDZNnZp1xBo1742nmmksNwTK9nwxUDvjlscWAeO0Athuo3BAbH0nhNE7t9TaIxocd++v3NFTG+ePzdyrpXUpt4NkWDck+Ahh7vL3OLYFekWjnYQ2K6vePMBzCTNzXTa+rxMmavM/HXHzhUn7HgRNdgV3vhhCliCX+Qv8z06iz6kEnmsi8hKTzjSuw2G9RVBbG/6dugdlFvkDgr6jeTyORXjByNFOMDBbuf8SSYuSiyGTHCPkl6E0NE28Vk9toaLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261022105027099003)(261026140227099003)(261028144727099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0dTRnFPcDlEUkxaMVlEVEMyUUxIUlN3UDUrSUh4M2liQWZ1bkdwTDArWUhI?=
 =?utf-8?B?TDBpU2pCYTN3L1hlcVYvMVVVL0tDaXZQMC9PSy84WmYveUVBL0ZJeStjM0Jz?=
 =?utf-8?B?bXR6RitqdVNDYlZDbGZOMEZ3dmd2MzRUa3ZuVWlpbTdEWEJOWExrckoxekNn?=
 =?utf-8?B?cUJqT0Q5RWlySEpzU2Z5bXlFL2g5OHM4UnpVMWc5eUliWkZUMTE2UlNhcEt6?=
 =?utf-8?B?V2NPYUlxTXNRaG1yazBLQ2pqcUlPeGp0ZXNlTWdjNWZkeWF1MW9KOTN4Q0lt?=
 =?utf-8?B?VFd4ZTdpVTFnU2IyTjBibVlPbHZWQTBrRHFTcVBUSTRjUUxobWJ5aUtHekt3?=
 =?utf-8?B?N2VjTHU4K3hjTnIzelczb3FScDBFRVZ1dEsyQW40VENVYytmbmFMZ2Q4cmNq?=
 =?utf-8?B?bDlkd2hQOFB0c0hHK2hSbjcxSGtyaEh1UWRtbkxka3VKUmhma1VyUTdBSXNZ?=
 =?utf-8?B?by9lbTZCZ0JqcGtFejVYNnluUXdxSi9Fc1dIU3R1K29FaWhJdktaUjB6aVNt?=
 =?utf-8?B?NnhiWFJyOGM3SkZKQWYxZERZejgyOVVJT2xCbHp0TVBCNlp6OFdQeVVOdFJk?=
 =?utf-8?B?RWRHeEZUKzQ2N1hGcStyazZaUHdYQ3dyNUJHYWEzc1NmWUx0U0FxR1d6TWl6?=
 =?utf-8?B?ZHlYd0lhN0JxK1llZW04OEVYMVpmd3NwOWNCb2hpQTF1b2ZxTTU3NDMzSUlT?=
 =?utf-8?B?VVBmTW9HSDVnVE8vcWNqVlNJWUZROGw1V3pvbjVFVjRKVVhtVzhOMVljcFc4?=
 =?utf-8?B?SjV6MEplQ0RQYzljOCtnRUJiUlZTRlFzblhQSTlBMDhBK0V2RjAwNTFZalFu?=
 =?utf-8?B?Y0FqOHpKTHpoMW45M3VmbTNTenBsU0ptaWJ2d2NFeHJZNFNhMTFLWTU0Z0dO?=
 =?utf-8?B?YXltMTJMQXBjOFJlazU1QzQ1R1UyTzdPdUlCSUJxR2FUUnJnZlozRXQ2Tklq?=
 =?utf-8?B?dUJnMEQvRllKSEtBMFdHbStSMVRGNDd0WTZ3SGRaNk5OREYyTU5SN2xibThu?=
 =?utf-8?B?UFpkbVNJcy9JUGhNMGZ6TGU1cWdmbzFwMFZGWVlzSm9uTWNxVzduRklEZFRa?=
 =?utf-8?B?Wk1saFRTWHRnOE1ZTEwxbjRiWGhGTkxkY3I2U1pkVFBUbjdyWEd6SFA3clI0?=
 =?utf-8?B?cVlXdVB0UHZScTBuM2hZejNPcGp1L2l2ZW1kRXBheHpnc1NUNnlodXgzTUoz?=
 =?utf-8?B?TisrRTVSd1hRSjJhTUZ3ZERFRndLcnRvTXR5VStsd0JtSExvVENqYjNKNFRw?=
 =?utf-8?B?MmFZeHZJYTNpZmhEakxiSE55ckptb1FPcm5jR2xNTytydStsUXdsNEpYS0Za?=
 =?utf-8?B?Y0x1UzdWRnpNd3RUVER1TTdCdm9WQlBlWGdoYmxLeHhra3VGU3FUWGRlbVQ5?=
 =?utf-8?B?RmJrd1lNa2I2dDEvQnE5dnB0VjMxYnE2RE9Gc2dVMHBqQ0hSRFFwWDVRQTBW?=
 =?utf-8?B?VktNNmJWdC9rZFQwTjJBb1AzNTk1UFZrWE9IKzI0RHFkODRQUnVIQWtwaU9i?=
 =?utf-8?B?dDR6SlhSUnIzN2pvWXg0ODJEUXNjdXR6S2ZlRTMxQ1U3eHk5LzlvT1FRcE9l?=
 =?utf-8?B?OE9RWkhuRmpVN29WcGExajUwc1czYXBzbExBV05jaHkxN2hDSHlHQ2FPV0F5?=
 =?utf-8?B?b2U0WENMOXkrTWhzTnRaTnFYdjNhcWJvajBZWmV3WnNWSFhiMHkxblZFVU1h?=
 =?utf-8?B?Z08wOXRTL1BITFBZSFZhTDA0dmYvYk1xQ2ZFbzBQZzVsMmxaMzZCYzdsMnkz?=
 =?utf-8?B?Q0duREtYeWs5Smw3cjRTVEdYRmdNYnlxeDNOa1VjZGk0dEI4ZEdtWWZmek1Z?=
 =?utf-8?B?MzQ3allheDd3MHJzWlNvcktuejEyQm9aTU5NbkV0MCtnNmNFcmVxSVEyN25P?=
 =?utf-8?B?VkNXZGw0K3pCWXp6czAxT0kxQjJzTUJBK09paVh2Q2RrcHhWYnpLa3pwdVFw?=
 =?utf-8?B?SHc4czdhV2NKWk5ucUdrYmhGSGYwQmovcHZhd0oza0dCcjgyOHo1bndRWmxL?=
 =?utf-8?B?S29WcDVvb2dIMGJ6cHpjWGZSS3BSL1RPTUpSOU9HRisrTHVnNkJIdy9BQk9R?=
 =?utf-8?B?ZGF1cytzcHRqZFFpem9xYjE4VjZBcCtEUm1wa0NOMEFWc3cvWE1iSGlkeVFw?=
 =?utf-8?B?RkVqZkVvVUtVRHpaWm1kaEUvcTdKVEE1bENPT1hISkRMQkV6M1c5Q1puMVlU?=
 =?utf-8?B?UUtLanlEWVRURDlkaE5KVksyYkdQNGtBYUg0VlJVaTh6N2FGZitiVFVUcVBZ?=
 =?utf-8?B?NGkrK3pqb241YlZBUStSMW93a3diMUllNmtUdWdiVFE3REZvRVRqUEtWbVI2?=
 =?utf-8?B?RHFZVkU0cWg0aldJRE5XeHlITjdDUDJYWXJEaGVqWGlacXBDNHJOR093ejFm?=
 =?utf-8?Q?/7gYUeHTTU5YafaA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24797a6-6ce9-43ef-2c1c-08df496a1944
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:00:15.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUiKIWWYaezfT5ZmVfosDrd5DoTzpyksilrdojd+YY6O+83PGKGuCDfK6SxfiPx1uSUyR8+DVpWvAbNJmbxy+vuNDtfOTSQl9puGHj4Vt6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQYPR01MB11558

> Can dl_boost_blocked() skip starting a period for a task that left
> SCHED_DEADLINE before its 0-lag time?

Yes, by reading. This is the waiter that keeps an expired deadline,
which you found on v9. v7.4-rc2 sorts such a waiter the same way. v11 will
keep it as a known limit, with the question to Juri in the cover
letter.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

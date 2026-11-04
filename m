Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.95
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793796780;
	b=Q22afZDfiJunOh8Q+5GwziNczoGk687jx/svWU4YHi0eszGtevsuS+1AKf5oq/h/lDvX
	 V1ITIjZvMBK5+jf4WvbShb/Ay2+GOYffrxhIOI+KA4njm631HRQqXuAB0R8CjDgc6W718
	 qhPwG561z/SYfKfRHEmx2TLUjpQ7THukoAKU+h4YYWtnjxljQtjSx/A2GvaJxqToHhETw
	 llzJ+pNFvTdd/PKCS+nP7BZFzhCZTuxgrFrZQrlKRoqTrWajOpdr4Ahm/iUmPTTy6vgkB
	 JWYQZ2Q0kBUA5lLr4bYkeC9XkL9zrAq/6bVS1ZgWtTjoZcJ80Dsa89lk8P+yvLGu5hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796780;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qyGUyHFJ7o8vvx3s4dL4/0NyZ/TbiTkbOx0FESJVHek=;
	b=eqZsuOibnMeFS25U8M4QF6bKn6d/5c6Tcv9K81TqkQlZspoMUNFSe7wtHlhDmYj8Rfie
	 Hq/hoxSbHpSdJrNQXbyhCeVDOHgisFTdhmgk27XrbJbdzOG0BmDUL7rmX/3Znk+HntwI8
	 6cIwkttAP9ePkiXjVZgUSC0pR57z9UwCNLIVHYsZISIOXEPvCu+VIJyr9pUI1mSZh1Ena
	 gDremslPndQr/52qokXhvsUlSe+4KODMBHQk3vClBi0GNckdTMdHzxaDnd+CTuYIMvsUa
	 /ZLiYtH8wkzCtHGDdiDHaA/jaypwMUFdd2cSyIOa3JMjKjX27OS2C31amBus5NW8twQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=Rdp+NVPi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.95
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9833606A31B
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 12:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9833606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=Rdp+NVPi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYm/AA/Y74Tv6ktCfQZdtNYd8YZQ1250Rvcf/GpJyAa1tyHnbRyov6JIBopR452eU9KIv++XNHIZYFB/fdNuq08wLeyFUHO5wnSDf7uGP4Xsv3ulo+HAC6OEb5ierWD3SanVhdn5kxCNFaTxpVm/8ilsegp4Vd4Rr0sS7+GBCvi/L8+bWovdVxMN1fI7CbsfHXndmTe6mxNcvQFH9vYq92dswYMy9SkmQwZ5PFlShEh9tTH/Mt/d8/ON07cy6vhIWhcYDRdZJ7oYZo87zevYryQEMwVGXE7czPPTwSIOATt8HjWlRxxXG4pEH2pnh3hvtrUV9zGxXwtdG61+XsM51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyGUyHFJ7o8vvx3s4dL4/0NyZ/TbiTkbOx0FESJVHek=;
 b=ZmDeLYwORN17rm3K2SivW5XCsEbha8bzLsG+JX+fjtSNbxQeQtKuF6v5I7TfJ0eUdKP0xeMHlfqgkvMZnGyAxn3UpbDeN/rTUBLhgivLdWDBXePYVsXgYLxa3RVM96q4ha+YHVgdHT09PrMpMIff2Ypg3BUZtWXnzr3xYzIZ/S8RLuCDprRVkLIbphYf3LEoao9uE8yBzcJCYPtyvz+9UjJ75CuIpg8VGAac5Ma5NwQCeqTeIjY2m8+MJdHMOOhcytxkXpLiTkfbee2osUjbYySHD31XJjAoXKDXSqqDEy6t+yYmq1Ou8xG444ptzazGPllxkMRHD53HyMzRBGjEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyGUyHFJ7o8vvx3s4dL4/0NyZ/TbiTkbOx0FESJVHek=;
 b=Rdp+NVPi/On5zI7xf0b1TP3NrheAWAmePNIuY9izY4h1IxQags++5GbRxWLZxELFHXY++q7clexFIPfu3rDX6dk5olIzek5/zEOMPXoCa8vstT/NFViPV6XGXLH/zgS6lsXH83TNyGKsKXuCI8y/iWrhO34k/1bVkG8Qd4adw6g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1075.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 12:52:47 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%6])
 with mapi id 15.21.0592.009; Wed, 4 Nov 2026 12:52:47 +0000
From: Jingxuan Xie <jingxuanxie@deeproute.ai>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH net v3 0/1] af_packet: avoid waiting for TPACKET_V3
 copies at retirement
Date: Wed, 04 Nov 2026 20:23:24 +0800
Message-ID: <179379500489.189393.11299513853625665657@deeproute.ai>
In-Reply-To: <179369815762.488859.15460471694371846273@kernel.org>
References: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
 <179369815762.488859.15460471694371846273@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SH0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::21) To ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9)
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB1075:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e5299c-8936-45a5-6434-08df3a728700
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|10067099003|22082099003|18002099003|56012099006|4143699003|261022075727099003|261026121527099003|261022115727099003|261022105027099003|261026140227099003|261028144727099003|261021123027099003|261009223027099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	chYY4PGOCQigQPTL5m4fmKD7u/BHCgAexlhDC+4PpyeAVF12mhTipkVl077R7jqVCxdaRS8riXWiD7ZUXcvqjGUnj9gU+0q6dvBRp3d2Tx4KRPHYmpdEstK1j3FfNYud1gVM4ySdThs4Ez7IOhcx69Mhy0HsNdYbTA3qjyihcDkpvJZ2tfzouk4DSVLfENojhiyrAL4yLAw43sX8MUu5DI5morpg/AUuXrIbZOd/dlrgzGVyja5GAo3A3cdwjrk3mdMSmnBkGldh+NLmxiUPpZjEE65xyFfxP5X2HX+ZZwDck5tA/zHlY9+n1ni+xOipXsFoXPKRFEBR4fysjtvEKMSYBRBaqy9C+fI6uP7OrVOsJMkyhNjPvA/X5i8PKlV58WdnGy0qGdzs9qNq8lp3bkThsv8Gb5t6hhj3Zk8P0knP3VrJs7MW/CHTwJwrE0n2QxSmxtq+2Hwr/hb0AaCyg5KemVc3k1ScgivTm6XE5PalHLrz95pgFLNAkSOsUwKpr6ydajFyFiUtotV93+ijuFLEy1KLFl9txA6/MBbD0a+acyPp9qM4+5VZkZYix90M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(261022075727099003)(261026121527099003)(261022115727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021123027099003)(261009223027099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3llNTJ3dUhEVFF1Y0FDZWZQL05ZdS81aGZOTzlXUDVJWTRRSGlkUHZ1WmhI?=
 =?utf-8?B?czVRU0cwK1R5TExKaEkyVldJMUF5UUhXOGpVTHFvS1RITDhWcWRIVDF4U3dO?=
 =?utf-8?B?blpZdldqUmRnUjhJd0J6OCt3bVVlaEJXZ1B0WkI5N2sxR3cwVTRyaXlxdGpH?=
 =?utf-8?B?SncwTkt0NFZhd0hvUTEwOXdSaTV3TER6WDVpemRzaXloWENkZHNEUDc4SnQv?=
 =?utf-8?B?YkNFTFpLTnVDZUZ2Ty9TY0lueVhFakN1QjY2YXpHSERaSk0xd3BZbTJsN3Iy?=
 =?utf-8?B?Q2lXeGd4SUNPbFEySEZ6RlhIL29Wem1kd2pLZitpN0I1Y1pjZG90ZnV1eXhK?=
 =?utf-8?B?VjNiZFFVUmVYbTIzYlpFVU9oS0ttWjYzWnIwbitJanFGN0ZUL2pnZzVFeURq?=
 =?utf-8?B?b0FQUmRUK3lkeWdBMlVUOC82aTh3a3U0OWloT1FxUDM4QUpCY0VYcEdUcW5r?=
 =?utf-8?B?OUNLTWd0YXU5UXJUVTlDdkg1RUZPdUtCWTVEVE9MaHA1aDhhYTZ4NUtxQ0di?=
 =?utf-8?B?M2hGMkc0UFVzQTJlcG0vWnBmeDhXK0MrR0xHeTZkTWlMdE1SbFBWQU1oUWVL?=
 =?utf-8?B?anltdlNWVmJjcktyd0NHaXFvZFpheVRmK0J3V28rN2NmeURVMms3dFNhazN3?=
 =?utf-8?B?b0VaZlg3NVhvQW1WYVl5cGh5TEN4Q3BPSWFjampTNm1uNXNjM3pGN3VLNkdn?=
 =?utf-8?B?eXpoS0E5Mm1NczkzQ0Q1WVEwV1JrYUFjZTFLZnFRWDhQRHp0R25qck1UNjdO?=
 =?utf-8?B?aVFqa2tUNDVRbW5mdEtkQ1daSFF3emhuOHZuaE45UmtXY3I1VUhYZkh4dkN6?=
 =?utf-8?B?OG9OTTBQb0llTTc4ZWVwcURJTHBZY2tKRWgyU210MFZoc2t4OEVIelVJYm1w?=
 =?utf-8?B?bTZBL24xMlFsUVQ3UEswYnA3RThpNVZoM1JOS1BMS1F2SjBoVE80ZllxNEt3?=
 =?utf-8?B?bkNFdktEbGNSWHNZbWhjRWY3TTg4dm1rQjR4Q2xwcWhVdGMzWUZrWjFmWnZE?=
 =?utf-8?B?UFFrL0NYMllZdU1wV2Q5TGdCOFhYQnpoc2dzNDh0MHhwNU10UFVuZTF3N3VJ?=
 =?utf-8?B?UGsvbHIwOTlXenlVdGJYb0tYT1M0QWl6cVFSNktwT2E2QW9TdFFNUHQ4YWg5?=
 =?utf-8?B?dVNLMndVMmg0eEJuWVVrcjJrLzNIUTRveThvOFJxTlNBWkpVYWM0L0JuNTZt?=
 =?utf-8?B?YUh2SmlzbnVqeHpHYjR2bTNGZC9YcTJPdVlJMWdVQUtHdVVpYThBSXVxYlpi?=
 =?utf-8?B?d25yODRrQ0R3bytXUHROdnp3RC9RRFEvOVhaSWowRE0yOW9SVk9XL2t2UURB?=
 =?utf-8?B?UkZoMGxWdVl3YUVSZUF1V1M4R01Sc3R5dlZYdVZHenJzU2RYaWg1R1VBM3My?=
 =?utf-8?B?czdUa2RQM2Y2RmlhMjlweUdST0NTQy9qby9QVEhibmZIR3BzZjJsMmpiendT?=
 =?utf-8?B?NnlUaEN6dURZWXlURlJRcE84cTFQYzFhclBMOTdYVEg1NlE0YWNtNVI5WjlO?=
 =?utf-8?B?bExJbFdHbDByaEJZR0x2Rk42SWRodmhRVnNreUtLSkxMMnlDc2UxOUZIaFpz?=
 =?utf-8?B?MEtYcTBGNXY3Yk1IRWhwa0V1TWV2ZXYwQXJGNnVSWXgwb1c2dWFBQkpCRFNO?=
 =?utf-8?B?SmlxeDFuVEp0OG5OYjBaWVZ4QU9sN0ZDZU5HZjBtSlFkdEJ2R2lRUkx4WmF1?=
 =?utf-8?B?YVB6UW4wRXZVaVY5MEtNc1liZVQwZXZ3R05CSUl2c0dlRDRmMkJlOFJTUFJu?=
 =?utf-8?B?MXdCbGdSbU10WS9EWURTdGRDbDYxTzc0MTBjajNFVndZTWY3aFp5UHRZMTdZ?=
 =?utf-8?B?VTczNUdML01oamNtQ3RjZnBQWlVtRWdrQTJMVHRPT2pEL1VYVDhQazdzb1Ay?=
 =?utf-8?B?SStwNitNTTdGYThMVHcxaGpoZ3BCNmpUelRTQS96OE8xeSttYllSOG5FbTNv?=
 =?utf-8?B?V1FDbzlpaG9PL21ZQXlYY2hSSmJlMndHM3J2UjhNd2R0dG9OcTBLNGNEV3lu?=
 =?utf-8?B?SjNNSDJ1Qk5rZjdqTXJZdU5qbW81K1B1V1d1WWFuZUxUcUZGZndTTkJWYlFx?=
 =?utf-8?B?QUV5cVlkNjdxZFNvbHUwbi85Ym0zTW1GemlVcCt3M2RRN0pKeThSejhqWStY?=
 =?utf-8?B?NjlLVFRkQU9SMTlYOUxaZDh4bW1XWWMrRUZPcHFXZlpFWmxMUTZ0UzlLdEJT?=
 =?utf-8?B?SFpXKzhLbnpzZU9VTzBySkowRjR5Qm5hOUR0VkJCMWZTdEVmY1paTmRhQUVK?=
 =?utf-8?B?akdybm5qd0tqSXBFUXd4R25vTEV1NlVoTDNPVDJ0eVJuK2VtL3h4US9lYVd1?=
 =?utf-8?B?WUZJcVlhRVpES1pxVjkwckUxVDlDbnJPTmVXQjlyR2J0M0NsR0dpUT09?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e5299c-8936-45a5-6434-08df3a728700
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:52:47.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uf5BTD7NBUVWCjcZ7bvQBbWllp0XJqemTfZHv27GGa/SkEO04SBsLZtpawTyy5n+wU9x7Q0XL9Eb9N59+ecGY4AlQnop4rOxaco+BY0v98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1075

The issue was found from a field observation in a PREEMPT_RT
deployment: a receive path blocked for hundreds of milliseconds in
prb_retire_current_block() waiting for blk_fill_in_prog_lock, which was
held for read by a preempted packet copy. Manual code inspection found
the same unconditional write_lock() in both the full-block and timer
retirement paths.

I reproduced the ordering on QEMU ARM64 SMP PREEMPT_RT by delaying a
copier after frame reservation. Without the patch, the second send
blocks until the copier is released; with the patch, only that capture
record is dropped, and the block is published after release.

I will include this in the commit message if a v4 is needed for other
reasons.

Thanks,
Jingxuan

________________________________


=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E8=BD=AC=E8=BD=BD=E7=
=9A=84=E4=BB=BB=E4=BD=95=E6=96=87=E4=BB=B6=E9=83=BD=E5=B1=9E=E7=BB=9D=E5=AF=
=86=E6=96=87=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=B8=94=E4=BB=85=E4=BE=9B=E6=A0=87=
=E6=98=8E=E5=9C=B0=E5=9D=80=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E5=9B=A2=E4=
=BD=93=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E6=94=B6=E5=88=
=B0=E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=AD=98=E5=9C=A8=E9=94=99=
=E8=AF=AF=EF=BC=8C=E8=AF=B7=E9=80=9A=E7=9F=A5=E6=9C=AC=E5=85=AC=E5=8F=B8=EF=
=BC=8C=E5=88=A0=E9=99=A4=E5=85=A8=E9=83=A8=E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=
=AF=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BB=BB=E4=BD=95=E5=8E=9F=E5=A7=8B=E4=BF=A1=
=E6=81=AF=E7=9A=84=E5=A4=87=E4=BB=BD=EF=BC=89=EF=BC=8C=E5=B9=B6=E4=B8=94=E7=
=A6=81=E6=AD=A2=E6=95=A3=E5=B8=83=E6=88=96=E5=88=86=E5=8F=91=E5=85=A8=E9=83=
=A8=E6=88=96=E9=83=A8=E5=88=86=E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=AF=E3=80=82=
=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=B8=8D=E6=8B=85=E4=BF=9D=E6=9C=AC=E7=94=B5=E5=
=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E4=BF=A1=E6=81=AF=E7=9A=84=E5=87=86=E7=A1=
=AE=E6=80=A7=E3=80=81=E9=80=82=E5=BD=93=E6=80=A7=E6=88=96=E5=AE=8C=E6=95=B4=
=E6=80=A7=EF=BC=8C=E5=B9=B6=E4=B8=94=E5=AF=B9=E6=AD=A4=E4=BA=A7=E7=94=9F=E7=
=9A=84=E4=BB=BB=E4=BD=95=E9=94=99=E8=AF=AF=E6=88=96=E7=96=8F=E5=BF=BD=E4=B8=
=8D=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=A3=E4=BB=BB=E3=80=82=E5=9C=A8=
=E6=AD=A3=E5=BC=8F=E5=8D=8F=E8=AE=AE=E7=AD=BE=E8=AE=A2=E4=BB=A5=E5=89=8D=EF=
=BC=8C=E8=BF=99=E9=87=8C=E6=8F=90=E5=88=B0=E7=9A=84=E4=BB=BB=E4=BD=95=E5=8F=
=82=E8=80=83=E6=9C=AF=E8=AF=AD=E3=80=81=E4=B8=8E=E4=B8=BB=E9=A2=98=E7=9B=B8=
=E5=85=B3=E7=9A=84=E6=83=85=E5=BD=A2=E4=BB=A5=E5=8F=8A=E9=9A=8F=E5=90=8E=E7=
=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E8=B0=88=E5=88=
=A4=EF=BC=8C=E9=83=BD=E5=B0=86=E4=B8=A5=E6=A0=BC=E2=80=9C=E9=81=B5=E5=AE=88=
=E5=90=88=E5=90=8C=E2=80=9D=E3=80=82=E6=8E=A5=E6=94=B6=E6=96=B9=E5=BA=94=E5=
=9C=A8=E6=8E=A5=E6=94=B6=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E6=88=96=E4=BB=
=BB=E4=BD=95=E9=99=84=E4=BB=B6=E6=97=B6=E6=A3=80=E6=9F=A5=E6=9C=89=E6=97=A0=
=E7=97=85=E6=AF=92=EF=BC=8C=E6=9C=AC=E5=85=AC=E5=8F=B8=E5=AF=B9=E7=94=B1=E4=
=BA=8E=E8=BD=AC=E8=BD=BD=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E8=80=
=8C=E5=BC=95=E5=8F=91=E7=97=85=E6=AF=92=E4=BA=A7=E7=94=9F=E7=9A=84=E4=BB=BB=
=E4=BD=95=E6=8D=9F=E5=9D=8F=E4=B8=8D=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=
=B4=A3=E4=BB=BB=E3=80=82


Reproduced in this e-mail and any files are considered top-secret documents=
, and only indicate the address of individuals or groups. If you receive an=
 e-mail there is an error, please notify the Company, delete all the origin=
al information (including any backup of the original information), and the =
prohibition of the dissemination or distribution of all or part of the orig=
inal information. The Company does not guarantee the accuracy of the inform=
ation in this e-mail, adequacy, or completeness, and this produces any erro=
r or omission does not bear any responsibility. The formal agreement was si=
gned prior to any reference to the term mentioned here, and the circumstanc=
es relevant to the subject and subsequent e-mail in the negotiations will b=
e strictly "comply with the contract." The receiver should be receiving an =
e-mail or any attachment, check for viruses. The company reproduced this e-=
mail because of the virus caused any damage resulting from not bear any res=
ponsibility.

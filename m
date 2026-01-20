Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454A315769
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923100; cv=fail; b=Kl2DZe8PhJ2zR9KjqH3hgZVn6fj6S7+TgAJQr5wnEDkdHooG7gk8fqXDjOToEazMHRPaBsaX1w+/fZw1/jXSXHrOOppVnG7+lIhf5V1Ei+Jth9DxNVnQrGN78r6soTYR7ISOBb8wZTfWVD7sa6sGA3YBjmbGZSuOZWY1923nifo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923100; c=relaxed/simple;
	bh=DOMMyuIFUQSFhKEGtV6QD9zivWFsGTqD60FEmN9Wabk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y3UBTY734kZs0oAzPZKEMCpfPVrdYhoTXIE+tdny4qknX9gQvoakNyClkI3kY2K5AMjwGh/yMbdggg2lBjt37DdxiVhhuHkWqzP50++jYZVtXHpTwpkMsmWW1+LzUM/+TbTtrQHWskZ0kGG9foSJ7xlc1t+RYm4/5s7wCHyXy98=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LjT8bMJx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LjT8bMJx; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LjT8bMJx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LjT8bMJx"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RZBEz8nHnkeY4gH48CmSAo/QYB7JJphMsawmEi9wSv7VAlpYCAbppuMeKocVg7vhL9CD2dFyj9ngQnPEXhdXVpXvJw6ewQ9Eq3CvG+oOikDgXMk0A0EzgVOPvRPbHBmfzAMdzozAQ6KsxGMYxBS6q6b/1iBG7yUwKGn86diEaOB3Wt7CeUaE5kkR937gwlncSpWb1qt7dJHrK7HPrB15zGooKUoeGAkQvuo3UT0lq/qcMoWqh1hum8VHq7eOXrSpxUnK9KGFpsnQJPsy+A/7BsFO3eHmE6gTnzyz3buBoIzEqrG3ISDvVb9uvMHVQslkuqLqEwXTfiW6rMCM+uKjZg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U88958UOh2Mn3Pt/XEd9GfGwWcCwalcchPkkpLVS7I=;
 b=SFEkqXGUrslzIOEy/PeTei/3hmRpzdom9DpV2BDRyYxQUWvz3IaU7cH14hqotY42Vlyc3UdscmpirVlWO3XevEJcXpL5LGUQan8iIurHJTQllkY7Z9TxxcK8QNDqZnIOlxmlFDgBIMtTYFtImjYx/MYXuh1LoOL6pKbvSL7SEvrNU2pI4rTkOom1zXNJ+XXb+Bs9ieWOrr1gPC6fYsZXlEt4orAAheCaZzIp4FO0rWfKQEEV//9qcHKlp5uFD4L5MDNqOz0D4R+lxzcE/KI+v7iP52aGK7uvGdoKLS8ZDhiXVri4/TD0+jB2hRi/r6uJlX7RXlu/5vzLzY3QXMsVTw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U88958UOh2Mn3Pt/XEd9GfGwWcCwalcchPkkpLVS7I=;
 b=LjT8bMJxjsDTyfs1yth+8BciS0/e+bH1klUAuXa8POmI/SlVYt7YDuMTRUFjGuqy+D/DmNk85SUH+DLqnE0Cyl1cCL0Zb6rjPHrPXAoLTUg1qmDfyLcF9CZSSHKX9oucF5AkorTh9rgj69nHH6ymAUgQbCnJUrkObLh/2FnNvxo=
Received: from AS4P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::18)
 by DBBPR08MB6137.eurprd08.prod.outlook.com (2603:10a6:10:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 15:31:34 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::35) by AS4P191CA0024.outlook.office365.com
 (2603:10a6:20b:5d9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 15:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 20 Jan 2026 15:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSHViYjRr98kpu0hmeyPMdbvmXTJ61bpMiSYXfp0J8FcGm1fq6ddOfUC70AaDP9Pl87JROiVSoQHXlYmnqUMiB/B3LSteOrGFVdg0jY03YYOQvc8Os+zMxhizY6G4YVk8RTg+eyY2xR2uYmvziAUQuggBCYer0KvZny59/1pWCNYWqLa3J2wUCwAmLGrxJRpbVi89wyltBUqDm1NRUJs3bMdMG0WvgxwcQgmyhJKhFRa0jojecFmYHQOjC11UZKwhzSkm6j2muz82oWURDzEXTu2bdZiZsI67H9O7/t0gaSbcNtyKKfzGJTZBz0RPH6MDkPimcYvBUKZkFydmNghHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U88958UOh2Mn3Pt/XEd9GfGwWcCwalcchPkkpLVS7I=;
 b=GvyskFUNFsTEsjG4DHNMkb9fmZ5oA6IQOHVl4EoGkAyFT3OwjuzLYLV3Eyo2IC6cwePxA/XMQo93xGaA3yVxfF6i+9//W1QIePyTT6s7jKSUqoNiH+aNKsv+DKDpu59axwJ6CUDctROTarJ8gQ1OIioXchGkpAn334xJsqzDvxAgutcPXpkomS//Sqzs972akTa89YAskP3JqJjbL5CdPirwwdWQH8nNL56F8JyrYLiwUwupqsWMtvP2UQ7C/tgkB4qezsPJgOCy9kRCyToNbE2st5N/jVFflND5ZAhQSsH7n9dTxFAoC5iQd0+9i/El1hbg7B/W514b3Vlg6RiXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U88958UOh2Mn3Pt/XEd9GfGwWcCwalcchPkkpLVS7I=;
 b=LjT8bMJxjsDTyfs1yth+8BciS0/e+bH1klUAuXa8POmI/SlVYt7YDuMTRUFjGuqy+D/DmNk85SUH+DLqnE0Cyl1cCL0Zb6rjPHrPXAoLTUg1qmDfyLcF9CZSSHKX9oucF5AkorTh9rgj69nHH6ymAUgQbCnJUrkObLh/2FnNvxo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB8PR08MB5305.eurprd08.prod.outlook.com
 (2603:10a6:10:112::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 20 Jan
 2026 15:30:29 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:30:29 +0000
Date: Tue, 20 Jan 2026 15:30:26 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, catalin.marinas@arm.com,
	ryan.roberts@arm.com, akpm@linux-oundation.org, david@kernel.org,
	kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v5 3/3] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Message-ID: <aW+fkmy1Sl2JZ8dm@e129823.arm.com>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-4-yeoreum.yun@arm.com>
 <aW5qfh_bsGNRd0Vd@willie-the-truck>
 <aW6idotkGVoD692c@e129823.arm.com>
 <aW9qpjyAcFXJNGo4@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9qpjyAcFXJNGo4@willie-the-truck>
X-ClientProxiedBy: LO3P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::7) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB8PR08MB5305:EE_|AMS0EPF00000190:EE_|DBBPR08MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 219be97b-de9e-468e-439b-08de5838fddc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?B4hDuWa3mT8yw3omp0l4yWqT9UmUYhh67i2+1hE6T5fh5cXQcvNtcD/mkTvd?=
 =?us-ascii?Q?LpL79INdtL7sV5Ya6T7yI6TgVad80AMZsjO1HT1r+KzuQ1Y+BVc5cPs/BHE8?=
 =?us-ascii?Q?Ra/kJye7XTjhGUIEvQCkf1r+xy1rMV8JrRj/KzydZk7eFy/cJm0zxldfPKL9?=
 =?us-ascii?Q?ShkZ3llirTg6P/owDKyYcRXxFGEok4Rwvh8Q1QLVLPwRyUpB07SPCZsciFI8?=
 =?us-ascii?Q?nhm1shZ6WlIBm1BkKt1gZLIKAdDMzOkYp4FtdjKjIJD9Cvf0EVJGX60ikqSE?=
 =?us-ascii?Q?/ziywaQzky2t/xa55nu7VlwG9lrcvHvRykjJKdNW5BcF3Gf4HLyyPTlBGLsb?=
 =?us-ascii?Q?/1z2AIJMk4UebCHEjazFALD0jllgk+kvnjFblLTxcMSX77knRfVMzocwt3bJ?=
 =?us-ascii?Q?ertkrwOZNRLk0ukdKnG7fdW3UdABpAtLsb3FFpBo9hsRIfADfTpJmSXbcJH4?=
 =?us-ascii?Q?t7InamimY5sxiRZlR8YmYo4aeUA2o0cvz8Tj5bCdR2Vuu2dupOoPyz4MuSfT?=
 =?us-ascii?Q?NOOX8RSvF4CWXTb+9G64Gw7O5wx6yEVofNLpqf6MGUomZ+OAoi+cJMV2pgMd?=
 =?us-ascii?Q?PobsXHRmRay4CqHIj+9AQWtNoa3db7wTDzDvPZSvvAwAgTjr3yXI4hw9Jz9w?=
 =?us-ascii?Q?mJicbsIz8xjblfs4TpqvKnOAgNfBXE6SyMVWwsp7TnoI50XxFVjkrUZ0dHc4?=
 =?us-ascii?Q?ftco4qiz3HgJyB6RVol0WZsrItKZjhBi21KtWC/+5mFitvfHez2LQxK4f/8o?=
 =?us-ascii?Q?4tL8NlLHlbty5e9MA5Kvg7Hmz4H7ikpj37QLtutCSTiFG6hY+vqOdCetcUEn?=
 =?us-ascii?Q?Lw6jX1ef4LveOwQzXRgBAx+64ZfO5YoNwgMul0OjgWkYvF3R2zGETebWwsOD?=
 =?us-ascii?Q?mlODv1Zd8fED+/BPXidP8cIqXIpKMSsthVngdKZr53M13tCGXLGn9omSXpkk?=
 =?us-ascii?Q?XG38ZT69YnQFSfZrUad49bCn5IL7kQEakkrim9pIo/M6lBjkoJAs124oP7UH?=
 =?us-ascii?Q?JbOB2REn3y+C7E7nujcT/8/5yC0XaJnG2tWXLswHuPOHkoi9bYznbEe5YzcH?=
 =?us-ascii?Q?3Rp/h7y31KmCaGIGZe0hFZrqcufGouFnQlsg/L/XX7h0yjZY/nLHsDhlxyvH?=
 =?us-ascii?Q?PZwXAbMwJsoMqv2Xyt9Eq/zOGIR7Ieh3i+nkZKOiDFnFArPW/X3Cqi5kLwjH?=
 =?us-ascii?Q?DLEDv/mw/Z91wlFF1qaApCAZ8KxAq7ihjTjjHkrBcQE5/gc7IulERXs135YA?=
 =?us-ascii?Q?9mWg4x7qxxqCzvpTJkZ8rpxqPOU3JHGdW8i50U2rRhL47gF0kcm3phdBWqsc?=
 =?us-ascii?Q?thuXAVFPTL5NE1k2jP7bkmwk3gY7BqpwhwBZ3mYMOHsWWAqsg72OSJBsBq3k?=
 =?us-ascii?Q?mPwC/kDkOiY4nvYcZgi1w9QnxmGiEzBcAMASEccmGsMAkhauspMnV4Mib81O?=
 =?us-ascii?Q?xD6KLWrRjgg+UfpdTN4ZIw6ikHwhhU3JMFjzaMbdrC/bd8/h1eTVUoP/S+kr?=
 =?us-ascii?Q?kQnAZC0AuWGwhjoNeGLhIkQGBqlu9JTNyuC2MSRneaGpsYHI+S2qTAXJcfTW?=
 =?us-ascii?Q?3ysB0P3LoomdH7ESXbU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5305
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	365319f8-f725-4655-719c-08de5838d750
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|376014|7416014|14060799003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k3BLXv6F2qZts9Pyvsdzmfok+kNW/4BmfEmu62OLtTqSV+qPZFISXnN070XS?=
 =?us-ascii?Q?ryXrbZNI6fB/WyzgMIUlEYpy3y0CabuvLHa2XmcjWI3pDC+hBepAarI2WTwD?=
 =?us-ascii?Q?A/4EdnApfrnF4QTsulJ5dv3JTOBYQ55SLYViTkoUigGfepnG4RXNZ5FrU9zo?=
 =?us-ascii?Q?iHE7dZedV8mkuAM1JdzCKcKQT/Lz5uFzzKqO26oIkKmVaUkX2guRrTVoci1V?=
 =?us-ascii?Q?tnhTwtBfNR45UBejwF5L9Cpd1epwlvpie42lFKcxFnKaHLKFqSfFXBgKsQ98?=
 =?us-ascii?Q?NBQ2AkFJLaOu3XUqoYsxMu3+eVjwYSTXHr86mgMSZKbfVBbEpzP/opHY/MQF?=
 =?us-ascii?Q?8TqFHeSdwex8H5txoC530Wf0PmB+O+uDV1DMJdrf6aEpukdbcoiBoX6GGcXa?=
 =?us-ascii?Q?o7lWErPd5CU3/r0j5H0L6bQS36UbxXM+lTLEgqyKYBvcESq4yfBQ2KDebNOt?=
 =?us-ascii?Q?GJojY3rduhnf4VIL0EQoL2cnb71wuTSrEjr1UMty2BjwYVGciD5QuwUIfY3N?=
 =?us-ascii?Q?vDmnqSIwclN6LuEarXyQbqzIBC7R8DIlpMVu5mpwCf+ZRi2QOExTYvMCuzOr?=
 =?us-ascii?Q?8okiv8LyC4lHtNR1KVdKI5bW63tFMafHXPAZhktk2cqvXIWjcgGSYL7Fh5ap?=
 =?us-ascii?Q?bH7dOvWiLFTBOXYGjJJESWE3NrwYU+cHclB+DUjiBcywmHpsomIooZ3+F5FI?=
 =?us-ascii?Q?ez4OsZyJe6v1fnvk2tMaBvGPIiwZPKF5/oyj73PE3enIlTCDaG3/zx/fENlP?=
 =?us-ascii?Q?PZFn/EG6C+pm5jZvbOIQ2up/OOb7RP2g/V8mH6c69mwD1O5d3lxdF1xqMq8A?=
 =?us-ascii?Q?LYeKM/LRxYskOtJjJTvcfBC81e+q8nWkmx+FSlk83gYjcQN5Gw3TgRs171s0?=
 =?us-ascii?Q?FX0ghdeeukXOoVWO7p94DbUN+5AX3g2vAu51JFQmmxZGj1pzWAlRLN/UIEoK?=
 =?us-ascii?Q?KvIlQxUoeMFAK/BKWGV1xN8HBXx/4vsVnrM3HxvLTLEHdlJY5HXyJ5Lsh/yZ?=
 =?us-ascii?Q?cnMFqIS6rLxq0mJva5zH9QdP1ZUD+NV1N7p9BiAf2nKJMoop2FJiu7ug+y2G?=
 =?us-ascii?Q?NQxLqYMUxn7Dj+1dEsrol3fQGG80VFppPjJcMEkryJ8fDjHqCeVm36qpTl2y?=
 =?us-ascii?Q?e5DyZHumQAjaqdbaRGDfFi6jB34on3et/ghnmlzzw+zZh8H7Zy6dySkp6cVd?=
 =?us-ascii?Q?QjuC2q5V8tBlIV+DN6Sg4lTzn/NaU8xTtw2Iu2R44ngRt2b38VoTeOZfc5JY?=
 =?us-ascii?Q?nABMJ7ja5Fuqf6QJLeIrybamg/ZaDeMarrtxUmrNK/DlG9SSZr2iUr34aVFQ?=
 =?us-ascii?Q?EgpGKkfwdBeQ6lG6u2AKQAgGL6r0fGSF/dQb/nnQD8+L+z1g4pGDWzcT+e+0?=
 =?us-ascii?Q?AArQ8Z+pzekQLpaiiTbZTEg+Sy10vpPV4VLC1DtNLnq9ldGLe0EgHsiTD6NL?=
 =?us-ascii?Q?eSOwiVYSSs+iXU/4XNo6BILtw1jRpu61Zty6tFqJKK9FAqkAmsKkC+dakjEx?=
 =?us-ascii?Q?aG4SYofI//BSjcFxL8z/NmF51NFnBoAOtst5JDGrj5iF6jcgeupXi2+/bTCE?=
 =?us-ascii?Q?ilr94tQ3joj2omB/r3GY7wEmecvJvwLwhsC8m6Y+w0NfucXBBY+pKvNRy/IF?=
 =?us-ascii?Q?OaVpOUxPXxbnmgcyhbZqhs87ybGU3PJ7xYPHScCcSlc0RKYeEfWlq9jwUYSN?=
 =?us-ascii?Q?r5/f7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(376014)(7416014)(14060799003)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:31:33.2791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 219be97b-de9e-468e-439b-08de5838fddc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6137

> On Mon, Jan 19, 2026 at 09:30:30PM +0000, Yeoreum Yun wrote:
> > Hi Will,
> >
> > > On Mon, Jan 05, 2026 at 08:23:28PM +0000, Yeoreum Yun wrote:
> > > > The current __kpti_install_ng_mappings() allocates a temporary PGD
> > > > while installing the NG mapping for KPTI under stop_machine(),
> > > > using GFP_ATOMIC.
> > > >
> > > > This is fine in the non-PREEMPT_RT case. However, it becomes a problem
> > > > under PREEMPT_RT because generic memory allocation/free APIs
> > > > (e.g., pgtable_alloc(), __get_free_pages(), etc.) cannot be invoked
> > > > in a non-preemptible context, except for the *_nolock() variants.
> > > > These generic allocators may sleep due to their use of spin_lock().
> > > >
> > > > In other words, calling __get_free_pages(), even with GFP_ATOMIC,
> > > > is not allowed in __kpti_install_ng_mappings(), which is executed by
> > > > the stopper thread where preemption is disabled under PREEMPT_RT.
> > > >
> > > > To address this, preallocate the page needed for the temporary PGD
> > > > before invoking __kpti_install_ng_mappings() via stop_machine().
> > > >
> > > > Fixes: 47546a1912fc ("arm64: mm: install KPTI nG mappings with MMU enabled")
> > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > > > ---
> > > >  arch/arm64/mm/mmu.c | 21 ++++++++++++---------
> > > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > > index 120874a2d35b..6ea5b80ab54f 100644
> > > > --- a/arch/arm64/mm/mmu.c
> > > > +++ b/arch/arm64/mm/mmu.c
> > > > @@ -1360,7 +1360,7 @@ static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
> > > >  	return kpti_ng_temp_alloc;
> > > >  }
> > > >
> > > > -static int __init __kpti_install_ng_mappings(void *__unused)
> > > > +static int __init __kpti_install_ng_mappings(void *data)
> > > >  {
> > > >  	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
> > > >  	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
> > > > @@ -1368,10 +1368,9 @@ static int __init __kpti_install_ng_mappings(void *__unused)
> > > >
> > > >  	int cpu = smp_processor_id();
> > > >  	int levels = CONFIG_PGTABLE_LEVELS;
> > > > -	int order = order_base_2(levels);
> > > >  	u64 kpti_ng_temp_pgd_pa = 0;
> > > >  	pgd_t *kpti_ng_temp_pgd;
> > > > -	u64 alloc = 0;
> > > > +	u64 alloc = *(u64 *)data;
> > > >
> > > >  	if (levels == 5 && !pgtable_l5_enabled())
> > > >  		levels = 4;
> > > > @@ -1382,8 +1381,6 @@ static int __init __kpti_install_ng_mappings(void *__unused)
> > > >
> > > >  	if (!cpu) {
> > > >  		int ret;
> > > > -
> > > > -		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> > > >  		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
> > > >  		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
> > > >
> > > > @@ -1414,16 +1411,16 @@ static int __init __kpti_install_ng_mappings(void *__unused)
> > > >  	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
> > > >  	cpu_uninstall_idmap();
> > > >
> > > > -	if (!cpu) {
> > > > -		free_pages(alloc, order);
> > > > +	if (!cpu)
> > > >  		arm64_use_ng_mappings = true;
> > > > -	}
> > > >
> > > >  	return 0;
> > > >  }
> > > >
> > > >  void __init kpti_install_ng_mappings(void)
> > > >  {
> > > > +	int order = order_base_2(CONFIG_PGTABLE_LEVELS);
> > > > +	u64 alloc;
> > > >  	/* Check whether KPTI is going to be used */
> > > >  	if (!arm64_kernel_unmapped_at_el0())
> > > >  		return;
> > > > @@ -1436,8 +1433,14 @@ void __init kpti_install_ng_mappings(void)
> > > >  	if (arm64_use_ng_mappings)
> > > >  		return;
> > > >
> > > > +	alloc = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > > > +	if (!alloc)
> > > > +		panic("Failed to alloc page tables\n");
> > >
> > > Why are you adding this panic?
> >
> > Because original code call the panic() when it fails to create
> > mapping of kpti_ng_temp_pgd and I think allocation is also part
> > of creating kpti_ng_temp_pgd too.
> > So, I added this panic() when allocation is failed for kpti_ng_temp_pgd.
>
> No. The current code seems to assume the allocation will succeed and
> panic()s if the call to __create_pgd_mapping_locked() returns an error.
>
> Just make this:
>
> 	if (WARN_ON(!alloc))
> 		return;
>

Okay I'll change with this.

Thanks.

--
Sincerely,
Yeoreum Yun

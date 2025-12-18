Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3403E257851
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070164; cv=fail; b=ewg2fZnUOYEESNkEUs/CJw6iN8D2kT53sCl9pJLx5nfFVqAGu1C8ngw2zUclqzjLd7wvLhFtafFwUrzKLe6yaWbmZsh5iayGRTLwgdn51vijYwptp4RWT+a50qmGz/6OVvLKhdnEKs8INUNFcI4QXUb90jIc5LgOV863TpHfdR0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070164; c=relaxed/simple;
	bh=y1I7MPI4bm8aD3n+8ymx+z5C1uxyn6aQj49fzaCWro8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rfk5NPkwyk6FopTUtqCQYWcOQh6Ku4/emUvDlZ56b9OsGuP/IWVbelzClV6ol9H6yye0/coTudfXz0V+rVc7fKWj9w2rhVcl8NB99id6OVxR0TIRxWT9Tg4ux0yVg1rTkm0cTzhwi/bkrwxS59fLN0/THCDpvrhRGnonZG6STt0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sB+uqlRP; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sB+uqlRP; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sB+uqlRP";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sB+uqlRP"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uyD0ijqKkxWD+SLsfpqVqe7PNPVI4P33SwY4/6OLvrkOh0aZIsKb98N2rlVznO8Kq2crEvIyf+bxXgSmcWQZdX/q3P8/j8WnlOKjLw9g182iNIfOQCFow4NdL9zhrJzBwT40uR+ZVFDCAad5L+WnPLGq1x5rps1ljdFAc0mIbbk7X9mNSx4zpbxmeBQEhpfZSahbVPzXZTqZ9vXozeJuYw/8vSL93o4AbSNZAwZctGcLoP0Kt+LXRtdZL2ZO8ZxvndQ90O3S9Eoh8zEyKvvxxk605vpkfpCqsgYWpH8rrEMSmuu+JcseC+CP9N4rMEp2J3pkvcRDRdNfblgS5t3+qA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjF2R1RoaKIBiMeD86aWFYD7pEqTL1DfAH1vHGxmzP8=;
 b=Q2Wfe6ZWWO0ceqEGZuZ4HJhV85OqN0xW3irEmjU/kV1D/4E3W4L9uORmYNkmBWhl6N8rK53pE3x9fZULIjijfM2XKzFqkOpW+gVKXOjf+2ujvfOxDG+BUmN+xpRn+92F5Bq5huWoK2JV7AR4cfEsq0CiGvNM/HOJiPaQp+nRF9uHWNqj+sNLZ9Pr6QIJZfiqt4Ov6L7EiVrb9qywF8MVSxg59qO1WozI3B52Js6lwQPIBQxTdna0QqW0OTMk5aJIHxkcPiHOCpv4lvhd7p8+Y6xR6ShdNS8LdLhfRevCpi7qAO8EN3VlC788LvU6W5e3lpDy/S8ujKsVdYsu9eOHrw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjF2R1RoaKIBiMeD86aWFYD7pEqTL1DfAH1vHGxmzP8=;
 b=sB+uqlRPAqpUt79f451OVZRWM0W3dVYwQx7qylH/kfqWjCk3WynEZtd0rOEEO4eaZjtnuIbWrWEH5ZYxoy+Oq4y4nzu4cJJWfamwaNMdhwH8fL0XfYef0WMMGTR+2oFJtzNwGwXY27Gm6LyZ0qIvzARWkUJsFpWRdaF5BueFGo8=
Received: from AM7PR04CA0005.eurprd04.prod.outlook.com (2603:10a6:20b:110::15)
 by DB4PR08MB7957.eurprd08.prod.outlook.com (2603:10a6:10:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 15:02:33 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:110:cafe::bf) by AM7PR04CA0005.outlook.office365.com
 (2603:10a6:20b:110::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 15:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Thu, 18 Dec 2025 15:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4Ev7uFGX/3w7tRn5NCPdwyw/pGEYbMdwx/A3h39ezUxfsxT0U1XIxfa5h/yMP7lqk6wajRA4J1v5TUxOoQ76XgzvQvhY7pyf4NDQ9RYblbCWvRxRWA66gpIi4QYfxL4F8AiMinHonM5ccZKsHUJBlWWSW1QJ+JQifUfVJ7GMv5x/8Zzi+RuthhmZxNU2rvj5q2OyAf1OJZuwbuwKErOw8O6oFohg6nLmYEx/cXDIe30CTbNUTUTqeG2dFysW0IsuoLjTU3TsxdtJlbKXgXzO0Jw+LJSS3WuQpQXt5pOOThHkDm+oCgRyxbsYt47qOG/o1k/5xnQuWAM1pQbsfTXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjF2R1RoaKIBiMeD86aWFYD7pEqTL1DfAH1vHGxmzP8=;
 b=bG1v0C5qUzedp1js8NoYCKlL/Fulj/kiTxhSK108iHyT6xpZg4T777NF46wETspdB3KuT/6FVfJtlOXewVbtNiZ20+3qDyg6P7SKsJ6dyeQz3HwTBVV0aHQkFry6eBVEMqlCKvqdQ4QT/kfFv/arPP9uNX9gcodwGCcdeHCbyZ480MJCatyPFWeiZbkf7Nwy15RA/b77xvHocPwE1Q2OSJa7xfHLcUYGjgNeWRw5wJq6SbUh5icAbY+593wval5e5JuZpZVtmFM1mzSyXX/QjIZRPLN7XurkPU4oxYhtWPuRsbpGthE0rYWoBPnm01Oy7sLjrplBvvxOHw5xD81ZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjF2R1RoaKIBiMeD86aWFYD7pEqTL1DfAH1vHGxmzP8=;
 b=sB+uqlRPAqpUt79f451OVZRWM0W3dVYwQx7qylH/kfqWjCk3WynEZtd0rOEEO4eaZjtnuIbWrWEH5ZYxoy+Oq4y4nzu4cJJWfamwaNMdhwH8fL0XfYef0WMMGTR+2oFJtzNwGwXY27Gm6LyZ0qIvzARWkUJsFpWRdaF5BueFGo8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB7314.eurprd08.prod.outlook.com
 (2603:10a6:150:1d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 15:01:30 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:01:30 +0000
Date: Thu, 18 Dec 2025 15:01:26 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
	david@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
	dev.jain@arm.com, yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 1/2] arm64: mmu: don't allocate page while spliting
 linear mapping
Message-ID: <aUQXRpLzKbl+I3Gu@e129823.arm.com>
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-2-yeoreum.yun@arm.com>
 <73ced1db-a2e2-49ea-927e-9fc4a30e771e@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ced1db-a2e2-49ea-927e-9fc4a30e771e@arm.com>
X-ClientProxiedBy: LO6P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::9) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB7314:EE_|AM3PEPF00009B9C:EE_|DB4PR08MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: d75498c0-56d4-4dca-9e9e-08de3e4678ca
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?S14cGM5sOi/M0Fsnth/IC/bPqdlXrPLt4l8xLLR6f6pqKaWbejow16dHpdPP?=
 =?us-ascii?Q?7Ao7KMIF5wD1PT9kysZJ/+5CC3p0ES4XFzOZXyviIIT51WQzfa1u8rFMxlzI?=
 =?us-ascii?Q?pu1xbTKLxOuKf6MzFyaeKqjirzMD6uYLkorI9KYUl3g7B6dyRlRlM8ITRfzA?=
 =?us-ascii?Q?KjOsJqHOlA2bxYiBTX/KrFZ17Rt5BHF/+c6TpoO9iW+3Em6FPj12XeLnmLCI?=
 =?us-ascii?Q?6iB883KEQRR9WhbslsZ9y68N8zn8wcRTPfC8XNpVRlvA0dgsDDOVuI5dsvex?=
 =?us-ascii?Q?8pBBjzakLVqC7KgRiobY8py1NECJvMhBdp/gZ3VGjmUxEz/kIx5pa+VEOmD/?=
 =?us-ascii?Q?K9t994piuG2i8gcIKj6/OQNay6jLFPw6pkomcDjPWFx4bDCVfXspKXA8Og+t?=
 =?us-ascii?Q?qp6Uh3khXGPJgWgvJj6e9oZV0QoeEQUgciQ/AbloChTn8WutaOUo5Jrd5Oc1?=
 =?us-ascii?Q?K89c6y5uYnaLh7fHKHaOY+qe7F07xwTyPx0iZ2ugvI6f3+/3G3c0TbtAaKKo?=
 =?us-ascii?Q?OO1egU2Gr5rRFw8ZhZ2HvJBvZ+p29HCNqY3K97HCrUgUdyE6yme8kxu7RIWd?=
 =?us-ascii?Q?hDoV2OqgwhJqKvTzut2SHwlRyQQ+Ymqa87yurJgwVSoejKKd/ygUiNDlJf7t?=
 =?us-ascii?Q?tdG9e1EHWiwB+lhxy7fRAO87u+/qQwuIO8zQOP2vX03fKoZFg4X9p+m5X+Qo?=
 =?us-ascii?Q?cmVQUIt2RZRmiwlecBKFAO8GCVBh/insXIPZopXoRHyOPznQGAmk1RvZ0L4E?=
 =?us-ascii?Q?zbTwXmYCj7iICvNwn5YLQdMCWCLwjoaMMkkHr2XBwtO+dzyVGqrFP8Ob78ag?=
 =?us-ascii?Q?C2b3tlLUM9BsUCMeiyFzVmP3WlvS9DHP3A1YNlTx7P+5hIhLki9/TKQ+i0A5?=
 =?us-ascii?Q?UkNXXir/9XTd5zukU6ji2lQpRjXf+BXDqQ3qQ6YzMtP+G+nUVRAuyQcoMBho?=
 =?us-ascii?Q?76RaCuj1tbvBb4UggSkxpt3TuLrpmw4EaUAi0q5iR+CI7s1P0UWUB4mJMx8A?=
 =?us-ascii?Q?JXKhfrNiNPph3kyEHIvMxV0uiYpqjDjRlrjtn/I31fWrBNrRdNPus4MPxKsj?=
 =?us-ascii?Q?jORyq9ZrOE9wgRQYt998ScyniBWXe+iMtY5uCrBfEhvMpTosBSovUQRul5y9?=
 =?us-ascii?Q?wRezvsxwmP0Slh61MFu+aemXRExdYAFH8WWJXwaUVgZgQ5f3qw05TPo0S9dU?=
 =?us-ascii?Q?aIxAuPQnbZMpPT/bhnAb0U5yk4l1LD2zzA5Ho7xCKwTRB/C/XRQgwy/Cb4dr?=
 =?us-ascii?Q?3qGBTEwP4tb7wtu4kT5ZsAy3nfULx6ZgS9H2kJHG12TE4E7P5LPaNymBUbK+?=
 =?us-ascii?Q?N+t28fqqT1kwCyZUH/qp2HNEZVXW4vZGdrzTVZAvXxK5sCDB3kcFH0E4FaPK?=
 =?us-ascii?Q?rOwQ6WXBkzZDtjjYGGTYfP6B26xmyR7HLzkDzARd2khM2nSOYr4wp+xevLZw?=
 =?us-ascii?Q?DgjUjLTzXHLjAXtyTnMswaa6bJ50UCYX?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7314
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cc178d4c-a1d9-44e2-a070-08de3e46532a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|7416014|35042699022|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?050zvgj+FJCCkjM4LqIav77D68mokZCg+cepXNtlXAfis4MHPpdEN8Rowzzk?=
 =?us-ascii?Q?dhZimOQzmw40J5cN/Jbws6jY+8jfIMiGVN9siqIEQy0LH92k7OfGvpqIeB3T?=
 =?us-ascii?Q?b6nDIpIazY3JBTj+nVttreKc/za2zenk+80660PlmwGBeTKcK6trHWMPm38s?=
 =?us-ascii?Q?xDPtoes69TU3urEJljJc3b4KxHkdQYOxqOowzs1l7f3BAcAPqHi/PgkRfPMi?=
 =?us-ascii?Q?4tyjd3QJY74BaKyaZKK3jIKHWCRJWBvKRSZF0ZM5LqWzfpMBftUwXpK42hIC?=
 =?us-ascii?Q?lC4w7U/vKzxz+q/ZKmlXDUcrYY/EyBfIUrxrLByAHpTZ1SoaFgPJqD8E5OB1?=
 =?us-ascii?Q?JNURW5op/HlTny3/Lcqyy8cvebtdkXgDNQhmcQLnLvsCZA6bhp5OFu4hEHXM?=
 =?us-ascii?Q?aiDHmEvTAtmK1+zxcE4yhKppJ+cr4svynxzrzocR9GPg1f6jRsHiNo+BQBZl?=
 =?us-ascii?Q?eep3QvoC2EzZ20dOtvsaHWZrdWU8H20P8vjN7CHI5URoxOsTSvTZpd74/prx?=
 =?us-ascii?Q?Cb6B2clfIbjYbFXNCGbjybdTEG6pEesDjcOTwqU4Szqrvk++NWB0YaRy+ia0?=
 =?us-ascii?Q?25GXyXzW66SoYH9JE62sKZTm/7zHHfnmVD3dnPImIksp1lVW9whcJ6iq71s6?=
 =?us-ascii?Q?hxScjGiUxUp2kq9myfpK5lWQ1CKiwgqPCRjqy9y5t4qmAXkGUeOSa+EGnJ3h?=
 =?us-ascii?Q?ziAxbq66N9OvNLLZKLE40ZGBmcMEhheuJBWO3YXr3iHpVabgWRWwmy3vqKK7?=
 =?us-ascii?Q?THuYiLKTDrl5EoH9LlSTrOZ8m04/yiWnpEWzWOyoOLOag/1ApXYec0EEhclg?=
 =?us-ascii?Q?+QP8WJiFeAhoar5cNTHcNnwkiNzKElAGx9bZh/v+d58HoI1xJrBooDOtAb9f?=
 =?us-ascii?Q?xEWZ7AqJD3Cg0bOc+intyT3cDL+XkDacu8/NcjuLPN9ujX9gmlwXN042UMa5?=
 =?us-ascii?Q?vbRy2lW8Ig5lv1KEPo5J9ZuvNExKkUEKmfSY3dJ0wbh5m0r1H2CncYDa9Eos?=
 =?us-ascii?Q?+aJ3ps4pYWrf69FRMghf4ln3CSUqekLe+vT63cAwpGFdFVk20Cy9tloJRAwW?=
 =?us-ascii?Q?sw3INpz9Njj/rFTwRqakD4U2DvUS7ijA+2ceA+bmBkOra8r4VerLPkulYs9Z?=
 =?us-ascii?Q?aCjkluLXaVfvTHO4gmWDbVubdRRttTuz+hoL8rlYnmYlAt1SoPRKZR1opc16?=
 =?us-ascii?Q?mjmbOchO5hLFGKl0sS+Ug/weIS4Itu2AqM8Ce2f0lszWG7CFgqASKDP6Wqtl?=
 =?us-ascii?Q?JZpM2aVOAaHa14rk9kjSjVJ9VV2P9YzpsEXzY8JO53xgXo7C1wZ4v9NU2yy1?=
 =?us-ascii?Q?z7QK1BLMElrf7mU29+/V+NOmG/KBPeG6U9zENL3RZ/dwTOWIzagljGD3x68O?=
 =?us-ascii?Q?Voqzv7th9cWAwM0ymvRX25TMlruwTjyCKizdbAkNozugGy+YWfMWUqAsP+Zn?=
 =?us-ascii?Q?Y3r+6P4kaEuEV9hFB2HRfdWxlesXBDcHX1Qf5Q+7JjS+qor2H0dCQck6jbVB?=
 =?us-ascii?Q?s1/PeXkmQjpfFr+gzR9fSYPD7F1ezskIk+pKapR+NeuOnp6ktsniFs3hV9gr?=
 =?us-ascii?Q?AqGNks3+64IrI/6bl7w=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(7416014)(35042699022)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:02:32.7253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75498c0-56d4-4dca-9e9e-08de3e4678ca
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7957

Hi Ryan,

> On 17/12/2025 18:20, Yeoreum Yun wrote:
> > Current linear_map_split_to_ptes() allocate the pagetable
> > while split linear mapping to ptes by stop_machine() with GFP_ATOMIC.
> >
> > This is fine for non-PREEMPR_RT case.
> > However It's a problem in PREEMPR_RT case since
> > generic memory allocation/free APIs (e.x) pgtable_alloc(), __get_free_pages and etc
> > couldn't be called in non-preemptible context except _nolock() APIs
> > since generic memory allocation/free APIs are *sleepable* for using *spin_lock()*
> >
> > IOW, calling a pgtable_alloc() even with GFP_ATOMIC
> > doesn't allow in __linear_map_split_to_pte() executed by stopper thread
> > where preemption is disabled in PREEMPR_RT.
> >
> > To address this, divide linear_map_maybe_split_ptes:
> >   - collect number of pages to require for spliting.
> >   - allocate the required number of pages for spliting.
> >   - with pre-allocate page, split the linear map.
>
> Thanks for working on this fix!
>
> First some high level comments: I'm not a huge fan of the approach with the
> different modes to modify behaviour.
>
> For the first step of figuring out the number of pages required; there is no
> need to be inside stop_machine() for that. Can should be able to just walk the
> linear map without any locking since it is created once and remains static, with
> the exception of hotplug, but that is not enabled yet.
>
> I think it would be cleaner to just create separate walker callbacks rather than
> repurpose the existing walker.

Okay. I'll repsin with separate walker.

>
> Then you could simply change the gfp flag to a callback function pointer and
> pass the desired allocator as a function pointer. This would match the existing
> patterns used in mmu.c today.
>
> The preallocated page list could be stored in a global static variable and you
> could create an allocation function that just strims a page from that list. See
> kpti_ng_pgd_alloc() for an existing example. That assumes a contiguous block,
> but you could generalize it to hold a list of struct pages and reuse it for both
> cases?

If we use walker callbacks, I think it not only pass the callback
function, but it need to pass the gfp flag too since split_xxx() is
called by another functions. (i.e) set_memory_xxx()

I think I can remove the mode with the suggestion of @David
but, I think it would be still use split_args with information of
gfp and preallocate buffer.
>
> >
> > Fixes: 3df6979d222b ("arm64: mm: split linear mapping if BBML2 unsupported on secondary CPUs")
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/mm/mmu.c | 213 +++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 170 insertions(+), 43 deletions(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 9ae7ce00a7ef..e4e6c7e0a016 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -527,18 +527,28 @@ static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >  		panic("Failed to create page tables\n");
> >  }
> >
> > -static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> > -				       enum pgtable_type pgtable_type)
> > -{
> > -	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> > -	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> > -	phys_addr_t pa;
> > -
> > -	if (!ptdesc)
> > -		return INVALID_PHYS_ADDR;
> > +enum split_modes {
> > +	SPLIT_ALLOC,
> > +	SPLIT_PREALLOC,
> > +	SPLIT_COLLECT,
> > +};
> >
> > -	pa = page_to_phys(ptdesc_page(ptdesc));
> > +struct split_args {
> > +	enum split_modes mode;
> > +	union {
> > +		struct {
> > +			unsigned long nr;
> > +			unsigned long i;
> > +			struct page **pages;
> > +		};
> > +		gfp_t gfp;
> > +	};
> > +};
> >
> > +static __always_inline void __pgd_pgtable_init(struct mm_struct *mm,
> > +					       struct ptdesc *ptdesc,
> > +					       enum pgtable_type pgtable_type)
> > +{
> >  	switch (pgtable_type) {
> >  	case TABLE_PTE:
> >  		BUG_ON(!pagetable_pte_ctor(mm, ptdesc));
> > @@ -554,19 +564,56 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> >  		break;
> >  	}
> >
> > +}
> > +
> > +static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> > +				       enum pgtable_type pgtable_type)
> > +{
> > +	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> > +	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> > +	phys_addr_t pa;
> > +
> > +	if (!ptdesc)
> > +		return INVALID_PHYS_ADDR;
> > +
> > +	pa = page_to_phys(ptdesc_page(ptdesc));
> > +
> > +	__pgd_pgtable_init(mm, ptdesc, pgtable_type);
> > +
> >  	return pa;
> >  }
> >
> > +static phys_addr_t __pgd_pgtable_prealloc(struct mm_struct *mm,
> > +					  struct split_args *split_args,
> > +					  enum pgtable_type pgtable_type)
> > +{
> > +	struct page *page;
> > +
> > +	BUG_ON(split_args->i >= split_args->nr);
> > +
> > +	page = split_args->pages[split_args->i++];
> > +	if (!page)
> > +		return INVALID_PHYS_ADDR;
> > +
> > +	__pgd_pgtable_init(mm, page_ptdesc(page), pgtable_type);
> > +
> > +	return page_to_phys(page);
> > +}
> > +
> >  static phys_addr_t
> > -pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
> > +pgd_pgtable_alloc_split(enum pgtable_type pgtable_type,
> > +		        struct split_args *split_args)
> >  {
> > -	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
> > +	if (split_args->mode == SPLIT_ALLOC)
> > +		return __pgd_pgtable_alloc(&init_mm, split_args->gfp, pgtable_type);
> > +
> > +	return __pgd_pgtable_prealloc(&init_mm, split_args, pgtable_type);
> >  }
> >
> >  static phys_addr_t __maybe_unused
> >  pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
> >  {
> > -	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
> > +	return __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
> >  }
> >
> >  static phys_addr_t
> > @@ -584,7 +631,9 @@ static void split_contpte(pte_t *ptep)
> >  		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
> >  }
> >
> > -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> > +static int split_pmd(pmd_t *pmdp, pmd_t pmd,
> > +		     struct split_args *split_args,
> > +		     bool to_cont)
> >  {
> >  	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
> >  	unsigned long pfn = pmd_pfn(pmd);
> > @@ -593,7 +642,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> >  	pte_t *ptep;
> >  	int i;
> >
> > -	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
> > +	pte_phys = pgd_pgtable_alloc_split(TABLE_PTE, split_args);
> >  	if (pte_phys == INVALID_PHYS_ADDR)
> >  		return -ENOMEM;
> >  	ptep = (pte_t *)phys_to_virt(pte_phys);
> > @@ -628,7 +677,9 @@ static void split_contpmd(pmd_t *pmdp)
> >  		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
> >  }
> >
> > -static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> > +static int split_pud(pud_t *pudp, pud_t pud,
> > +		    struct split_args *split_args,
> > +		    bool to_cont)
> >  {
> >  	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
> >  	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
> > @@ -638,7 +689,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> >  	pmd_t *pmdp;
> >  	int i;
> >
> > -	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
> > +	pmd_phys = pgd_pgtable_alloc_split(TABLE_PMD, split_args);
> >  	if (pmd_phys == INVALID_PHYS_ADDR)
> >  		return -ENOMEM;
> >  	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
> > @@ -672,6 +723,10 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
> >  	pmd_t *pmdp, pmd;
> >  	pte_t *ptep, pte;
> >  	int ret = 0;
> > +	struct split_args split_args = {
> > +		.mode = SPLIT_ALLOC,
> > +		.gfp = GFP_PGTABLE_KERNEL,
> > +	};
> >
> >  	/*
> >  	 * PGD: If addr is PGD aligned then addr already describes a leaf
> > @@ -707,7 +762,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
> >  	if (!pud_present(pud))
> >  		goto out;
> >  	if (pud_leaf(pud)) {
> > -		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
> > +		ret = split_pud(pudp, pud, &split_args, true);
> >  		if (ret)
> >  			goto out;
> >  	}
> > @@ -732,7 +787,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
> >  		 */
> >  		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
> >  			goto out;
> > -		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
> > +		ret = split_pmd(pmdp, pmd, &split_args, true);
> >  		if (ret)
> >  			goto out;
> >  	}
> > @@ -831,12 +886,17 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
> >  static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
> >  				   unsigned long next, struct mm_walk *walk)
> >  {
> > -	gfp_t gfp = *(gfp_t *)walk->private;
> > +	struct split_args *split_args = (struct split_args *)walk->private;
>
> no need for the casting here; it's a void *.

Right. I'll remove it.

>
> >  	pud_t pud = pudp_get(pudp);
> >  	int ret = 0;
> >
> > -	if (pud_leaf(pud))
> > -		ret = split_pud(pudp, pud, gfp, false);
> > +	if (!pud_leaf(pud))
> > +		return 0;
> > +
> > +	if (split_args->mode == SPLIT_COLLECT)
> > +		split_args->nr++;
>
> bug: you're incrementing this for the pmd table that you would have inserted,
> but because you're not actually splitting, split_to_ptes_pmd_entry() will never
> be called for the 512 pte tables you also need. So you need:
>
> 		nr += 1 + PTRS_PER_PMD;
>
> I'm guessing you didn't test this as the BUG would have triggered when you ran
> out of preallocated memory?
>

Good catch! Yes. This is definitely bug.
The reason why I didn't hit the but there is no "block pud" in my enviroment.

> > +	else
> > +		ret = split_pud(pudp, pud, split_args, false);
> >
> >  	return ret;
> >  }
> > @@ -844,22 +904,29 @@ static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
> >  static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
> >  				   unsigned long next, struct mm_walk *walk)
> >  {
> > -	gfp_t gfp = *(gfp_t *)walk->private;
> > +	struct split_args *split_args = (struct split_args *)walk->private;
> >  	pmd_t pmd = pmdp_get(pmdp);
> > -	int ret = 0;
> > +	int ret;
> >
> > -	if (pmd_leaf(pmd)) {
> > -		if (pmd_cont(pmd))
> > -			split_contpmd(pmdp);
> > -		ret = split_pmd(pmdp, pmd, gfp, false);
> > +	if (!pmd_leaf(pmd))
> > +		return 0;
> >
> > -		/*
> > -		 * We have split the pmd directly to ptes so there is no need to
> > -		 * visit each pte to check if they are contpte.
> > -		 */
> > -		walk->action = ACTION_CONTINUE;
> > +	if (split_args->mode == SPLIT_COLLECT) {
> > +		split_args->nr++;
> > +		return 0;
> >  	}
> >
> > +	if (pmd_cont(pmd))
> > +		split_contpmd(pmdp);
> > +	ret = split_pmd(pmdp, pmd, split_args, false);
> > +
> > +	/*
> > +	 * We have split the pmd directly to ptes so there is no need to
> > +	 * visit each pte to check if they are contpte.
> > +	 */
> > +	walk->action = ACTION_CONTINUE;
> > +
> > +
> >  	return ret;
> >  }
> >
> > @@ -880,13 +947,15 @@ static const struct mm_walk_ops split_to_ptes_ops = {
> >  	.pte_entry	= split_to_ptes_pte_entry,
> >  };
> >
> > -static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
> > +static int range_split_to_ptes(unsigned long start, unsigned long end,
> > +		 	       struct split_args *split_args)
> >  {
> >  	int ret;
> >
> >  	arch_enter_lazy_mmu_mode();
> >  	ret = walk_kernel_page_table_range_lockless(start, end,
> > -					&split_to_ptes_ops, NULL, &gfp);
> > +						    &split_to_ptes_ops, NULL,
> > +						    split_args);
> >  	arch_leave_lazy_mmu_mode();
> >
> >  	return ret;
> > @@ -903,7 +972,7 @@ static void __init init_idmap_kpti_bbml2_flag(void)
> >  	smp_mb();
> >  }
> >
> > -static int __init linear_map_split_to_ptes(void *__unused)
> > +static int __init linear_map_split_to_ptes(void *data)
> >  {
> >  	/*
> >  	 * Repainting the linear map must be done by CPU0 (the boot CPU) because
> > @@ -911,6 +980,7 @@ static int __init linear_map_split_to_ptes(void *__unused)
> >  	 * be held in a waiting area with the idmap active.
> >  	 */
> >  	if (!smp_processor_id()) {
> > +		struct split_args *split_args = data;
> >  		unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> >  		unsigned long lend = PAGE_END;
> >  		unsigned long kstart = (unsigned long)lm_alias(_stext);
> > @@ -928,12 +998,13 @@ static int __init linear_map_split_to_ptes(void *__unused)
> >  		 * PTE. The kernel alias remains static throughout runtime so
> >  		 * can continue to be safely mapped with large mappings.
> >  		 */
> > -		ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
> > +		ret = range_split_to_ptes(lstart, lend, split_args);
> >  		if (!ret)
> > -			ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
> > +			ret = range_split_to_ptes(kstart, kend, split_args);
> >  		if (ret)
> >  			panic("Failed to split linear map\n");
> > -		flush_tlb_kernel_range(lstart, lend);
> > +		if (split_args->mode != SPLIT_COLLECT)
> > +			flush_tlb_kernel_range(lstart, lend);
> >
> >  		/*
> >  		 * Relies on dsb in flush_tlb_kernel_range() to avoid reordering
> > @@ -963,10 +1034,61 @@ static int __init linear_map_split_to_ptes(void *__unused)
> >
> >  void __init linear_map_maybe_split_to_ptes(void)
> >  {
> > -	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()) {
> > -		init_idmap_kpti_bbml2_flag();
> > -		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
> > +	struct page **pages = NULL;
> > +	struct split_args split_args;
> > +	int order;
> > +	int nr_populated;
> > +	int err;
> > +
> > +	if (!linear_map_requires_bbml2 || system_supports_bbml2_noabort())
> > +		return;
> > +
> > +	/*
> > +	 * Phase 1: Collect required extra pages to split.
> > +	 */
> > +	split_args.mode = SPLIT_COLLECT;
> > +	split_args.nr = 0;
> > +
> > +	init_idmap_kpti_bbml2_flag();
> > +	stop_machine(linear_map_split_to_ptes, &split_args, cpu_online_mask);
>
> This doesn't require stop_machine().

Yes. I'll separate with new walker as you suggest.

>
> > +
> > +	/*
> > +	 * Phase 2: Allocate necessary pages to split.
> > +	 */
> > +	if (split_args.nr == 0) {
> > +		err = 0;
> > +		split_args.mode = SPLIT_ALLOC;
>
> How would we hit this condition? If everything is already split why not just
> exit early?

I'm thinking about if all of pages map with CONTPTE only then
it need to be splited, but would you let me know whether It wouldn't be possible
for cross checking?

>
> > +	} else {
> > +		err = -ENOMEM;
> > +		order = order_base_2(PAGE_ALIGN(split_args.nr *
> > +					sizeof(struct page *)) >> PAGE_SHIFT);
> > +
> > +		pages = (struct page **)__get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
>
> As per the other patch, I'd prefer to see GFP_KERNEL | __GFP_ZERO here.
>
> Let's make this a list of struct ptdesc * though.

Agree. I'll change it.

>
> > +		if (!pages)
> > +			goto error;
> > +
> > +		nr_populated = alloc_pages_bulk(GFP_ATOMIC | __GFP_ZERO, split_args.nr, pages);
>
> Just GFP_KERNEL. No need for __GFP_ZERO as they will all be fully overwritten
> with PTEs.
>
> I'd prefer to use pagetable_alloc(GFP_KERNEL, 0) in a loop since that will
> return a proper ptdesc.

Okay.

>
> > +		if (nr_populated < split_args.nr)
> > +			goto error;
> > +
> > +		err = 0;
> > +		split_args.mode = SPLIT_PREALLOC;
> > +		split_args.i = 0;
> > +		split_args.pages = pages;
> >  	}
> > +
> > +	/*
> > +	 * Phase 3: Split linear map.
> > +	 */
> > +	init_idmap_kpti_bbml2_flag();
> > +	stop_machine(linear_map_split_to_ptes, &split_args, cpu_online_mask);
> > +
> > +error:
> > +	if (pages)
> > +		free_pages((unsigned long)pages, order);
>
> It's possible (but unlikely) that another CPU caused a split between figuring
> out the required number of tables and actually doing the full split. In this
> case, you would have preallocated pages left over that you will need to free here.

You're right. I've overlooked this case.
I'll handle it.


Thanks for your review!

--
Sincerely,
Yeoreum Yun

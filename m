Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C702BDC23
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767370684; cv=fail; b=gt4r8X+6HjfBWdKgpyq1NT1WRx4Lq+vdc/JxkJm+Nhnc4l7y+k/dx9w8tknXVjmxQwmQ/m3UniphNSq4UbdttMz5qr6SSV0k7X1vYpvoLVULw2Y6hHUs3HRbn357gTlGnL4Ct907sljAe8YsKlNUlslGQIwotG9Zpcq+wC1lWcQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767370684; c=relaxed/simple;
	bh=FYs34+a4gOZ6sK5zs8OaAyuE7YBoes1qINuuBw4vk+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aBCcvVj2YXeUuh176gYkthfQnkVqT+1PIJsolTMVk7nDEbkBb59yKJDq6Mf/ePJY30PrTXDZ/DqrrOCE1eiLSvHEBbpSx0F9P1lGNOBlTWR16wIVghqter16eVb1azBDzo/X7dNkfHejFiWl45iTTyK6vxNz5HKshuRJ26nwwQk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eonBYvIq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eonBYvIq; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eonBYvIq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eonBYvIq"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=S6FA4q3IV0PyS294IoIcAC4xjZvvVLS+eHk0GVSp8M7zbeS/Psf1Yryi+tUj9mUDWvajFGLahgMWO1Faq+V4nG4GR9m4VEooc+pXnOv7XJKe8NkdEQR5todQBOwhu5fXFFEipdMSKFFdiEyH0HL6nX34Xfaxrtv/zRnHKHi80ZiuVeaypbJ6NAUovQz8MCD55HHHHpn4oxKE2++c1RbS1/ulMrP/siPR1NKOBX6WdfChuas/98tZ1FF45v31bTaE9HJvGtya/34nupnxIRK+Qa4kKUcvcLOXLUIwy712+pOf5w3114OFxOL9GbdDT9x96NDNAJD22F4Ut40W3cuubA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++TlM3hiifgo1uvbRmZQFPvipjGklBC4hcA4FAfGww0=;
 b=qOOTcznSyJ1a33RIcgAAMZEr3xd6quJ39gADVyFxohwyDLlUmQdluvHd+DDAYEjXSnWhFotnLlWjgT2zp17ORjRXrpGEL1Lq1w/0XocBI79J/zSwF2A7OlMJuzDqzd8Vvd4lVkdqXLTQiwzVP9N928wfY4I35x4TaB+cENxKc5lbHc+ZGcUeywUvpfQIoFw/gGxRZEg++MpXVkSaUPNKUJBXp3XthOg7OgrJ9jTF6AL9gz9RsGab5HvTzjxU3XxZa0cHPnIXXjdtbaX+/F04FjH2ZE64IOOTOG5WSJ45bKZu0DwG+azmGQkjuAzjBV1D/AD/2SHsz0ddxCH+0aSsBA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++TlM3hiifgo1uvbRmZQFPvipjGklBC4hcA4FAfGww0=;
 b=eonBYvIqiBCyrZLDfAfERQA6PH0MihegbHExlZ0nlxpjP1dCeAE86NsNr0qstk3mArxAZgWBYTIgSioftLcIhlytFZclY/975mQ8vpguRy/7Tu0jX37sBwBbjhfMkcJphBGhZEUQs1KaxBnT4bgbNShJfcz9R8OIj3h0ngMM3C4=
Received: from AS4P190CA0061.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::22)
 by AS8PR08MB6264.eurprd08.prod.outlook.com (2603:10a6:20b:29a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Fri, 2 Jan
 2026 16:17:57 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::e6) by AS4P190CA0061.outlook.office365.com
 (2603:10a6:20b:656::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 2
 Jan 2026 16:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Fri, 2 Jan 2026 16:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux1MKQNAgGaIViaiwv1H3W2ZeDp76+K3KPGklnT62r3lWKLHhRfLXvXnf5BLKmbwNcUqPTdI7xom/AD0f7n7UQiGd1bybxqxKNIPz5x3Fjl9cn3b6HoywR/Z5NJfVfij3vBq6RgkrO7yVn92Fd9ntgB733Qz/337wzBnPxMtrwKaCgtfibFXOR+wmmU+xhA1qOJHKM5x41I3nlsYWN2RIQdCHrYXoTtlgINGCntCSb5ef9oUBdsEXuJZDBIthZHDZBOfggmdLjbkiJLo5yzkbHk2IepilfjT7dBkGn9H7pUoccfviVSdfHCDKKjktkNfEtmn+JLQRpgKuGkqrJbx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++TlM3hiifgo1uvbRmZQFPvipjGklBC4hcA4FAfGww0=;
 b=mid42rY5daKcTa7lTEpA6g3IjG9KSszNZNzfl4zFYaTG8yxY5b5+3l/2UzV0TAeniZ1gFWxmqZB4MVDnG7aXZFZ+TuV4BwuzNMPFYU3fbI6M4V/Z5629heQjYEDT+gJB0uK1qHdKZnGe+ij0QbRGEMsV8UQehnEY+hfquNFQXods9HfKtGWL9GqPfzSU6hvq7R84hq5bTyKZ1hQUjMLBiJlIxwFeCPF+OmsOVCRYWLDuJVzwpqkeCCfqoHHidj3jOw9IAi4nV2ED/T+t7SsiCIhtYfRd48ekP4lK4DEtjLBiqNnFVcm/nYRHkwt9Rqp4azGPir6c9zLM3gOzWVdxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++TlM3hiifgo1uvbRmZQFPvipjGklBC4hcA4FAfGww0=;
 b=eonBYvIqiBCyrZLDfAfERQA6PH0MihegbHExlZ0nlxpjP1dCeAE86NsNr0qstk3mArxAZgWBYTIgSioftLcIhlytFZclY/975mQ8vpguRy/7Tu0jX37sBwBbjhfMkcJphBGhZEUQs1KaxBnT4bgbNShJfcz9R8OIj3h0ngMM3C4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by AS8PR08MB6165.eurprd08.prod.outlook.com
 (2603:10a6:20b:29a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 16:16:53 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%5]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 16:16:53 +0000
Date: Fri, 2 Jan 2026 16:16:51 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
	david@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
	dev.jain@arm.com, yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 1/3] arm64: mmu: introduce pgtable_alloc_t
Message-ID: <aVfvc6U6jTaecyvm@e129823.arm.com>
References: <20260102150736.1378818-1-yeoreum.yun@arm.com>
 <20260102150736.1378818-2-yeoreum.yun@arm.com>
 <4a315d79-bf82-4a90-9c9c-8dd1bdc43d38@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a315d79-bf82-4a90-9c9c-8dd1bdc43d38@arm.com>
X-ClientProxiedBy: LO4P123CA0414.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::23) To PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA6PR08MB10526:EE_|AS8PR08MB6165:EE_|AMS0EPF00000198:EE_|AS8PR08MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: d2742535-3df6-49f3-b793-08de4a1a7d96
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?nkAsGXWVt+Nx8IOsq1xaa1XUsrcwvTmUJQwJupX569Qzmt1c44gV5JipVfQ9?=
 =?us-ascii?Q?G8qMocU8wE92ijsuvlPtKHNflvKvfR08hs+7E8K8p6Xrt7xKem5Zt1fTtbVl?=
 =?us-ascii?Q?wiwrJc3Znjs+d7v450imI2geOLVrN2l3Q8deVwkwe+ieeieQFAWdUrOQ/36v?=
 =?us-ascii?Q?4tOhlGCBEHJ27m6mwziU6B4M6y3QihCp6q4DZEhlMjV4SzmQxjfwZ42vqYlG?=
 =?us-ascii?Q?F9Moct27V9kttVInl4LOa8iMY8Ga5viflGSexheAGbSAgLpkG7F4DARevwat?=
 =?us-ascii?Q?DqgA5fOpAdBTVe/1aQqemiUFXaiUo2uvyK/aGfdkv5gMLVvGnOvirtPXE4YB?=
 =?us-ascii?Q?vYXK/e8wl7qQdeyrepWBUSt9/XyX8y1pbJRQvck9nC92kkipQ7Hqy4CyLhIB?=
 =?us-ascii?Q?5LJwMpBDnslmqbZDSCQUc5NmuXDcwLt522RmLDbklGXdR315diHGYP+RQs3x?=
 =?us-ascii?Q?OO/mP0MDkja9xcPQCsqrdiSkkUytpqcqtJldh1Jv3/xWqVFcYAlQSE0Q6hne?=
 =?us-ascii?Q?oF09j+eVRMaSJS6taxp5UfLCIMCSCJc2EiXmuuCZxCcAVm0hR60OO5KXYo89?=
 =?us-ascii?Q?Jm3nMot8la4a5Q9nsncZGwA4ESnps3H/o/yAwElnNPis3LHpiw1z5j672Bk4?=
 =?us-ascii?Q?LkKCx++apqUy1f9tBGtzhzsM7GWpaNvtvSaF1rIZFtDEWC4q6NqZJkhZiJxa?=
 =?us-ascii?Q?6x4Duj6kZpgpml9wz4DchNa1pT9NVVadvvC0KkdqPgAOInI0xs3zDVQitKdQ?=
 =?us-ascii?Q?WodiFSQmNciHae2edEJhuFYem3wY6P8ux/Gr9bAyAeOZgB1e3dpV3/0gPYS1?=
 =?us-ascii?Q?JCB1MgV3js1YcAjpT/8/IenGiqAeL5qSAKobS2s4CYNcuKYAcQmM9XSH22s0?=
 =?us-ascii?Q?CoUxc0iPeCBUPbBwTvQlhsFYuKkS7nbWbnaYF0s37jS3MvNdVwHxPYUr+Wrk?=
 =?us-ascii?Q?sEl6G5CaIrvjjRb0OXJUmYXySFNuUcaP2uyL7AaJ0MxIk3hBcwUSBRZnZs5e?=
 =?us-ascii?Q?PWUXMtzoObPV9f3BemZxm722huGvUeMAmP1Lp93tXk4x+Y7+jHDqk6ybIOsl?=
 =?us-ascii?Q?QkjMzCDKeJxsFcDegTNQA9owuyinGHKpvu2QkAZH1zJSAaSZfGH5ewli2zRz?=
 =?us-ascii?Q?qKv5FrnI/HuOkQGwzdzhL++Nf/C4v/Gcdr+FSPEw7KbSTuAH+E2umX9gxogr?=
 =?us-ascii?Q?2tJg4bA35FJBfWa1YMVsASWKs832RIaVFctrqgxXm3Uuztw8nWM7F6q8yycQ?=
 =?us-ascii?Q?iKvXSdh/29H5LjpcU9rgM8vQp9+YFjT9keNFBHT/XplhxtEMQYZxzxOTaDK5?=
 =?us-ascii?Q?03SukNywYBi0FtauqlXdDY09XRnnLOLcoE4OjzACIAlvFLpjFFeahzael7P3?=
 =?us-ascii?Q?6VXVUV6JXlJ35hdx/fA5/Ncvli1HRYMHXrmXJjjjsce2p3lenviOx0VCkfqN?=
 =?us-ascii?Q?09OWg0wa+Uqy7KVrM8okC0CZQg7qUJ4D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6165
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d44b3a7a-c028-4905-bdcd-08de4a1a5767
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|14060799003|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EuJGZRl99v8WMeLPGrz4JbwcbGxMGaseXnTuM9DF45fazU5UGf5IgfTRFUNc?=
 =?us-ascii?Q?369tgGnPVnp4noz6m6+51BwxsTQAGp4eBI/OqA+yQZ5H7gosMaVG+oYNaGv7?=
 =?us-ascii?Q?yN5StqylFkYSMhF8cE1pHsRpRVMrjxhuKaYNOXnLeW37t8RJhxPG1j1lvy1A?=
 =?us-ascii?Q?U9L66QWHI2QdPWzd8RJ5GxWk7H+f/c3Z/LsH1JJ6ReFgivClduGmsezNYCSx?=
 =?us-ascii?Q?tXxcHW423vD0BzVcaQ5Ki3Jy/iFYOAZAZerYMyXHg62no0up/47VRaWmAm3Q?=
 =?us-ascii?Q?3QuLGvc138aANEjmKVMZPedk89byxLHwZHVuPvk8kBG2vkieEQJBgMe3DHeN?=
 =?us-ascii?Q?cVJDY++UELDdzo11w2ZsBo3RSCtXVmtjJ7omFl3I34uumxGbZUCMQjoRu3W7?=
 =?us-ascii?Q?eBEQs2hRP2E2x4ovWoTC6TbyFkGWB7uR9Qsvitpbfvd/pXmgVZFQW0b28shq?=
 =?us-ascii?Q?bNXPiQv9kow7Z+Kt0sqi6jGU7D4JocKBC816aZlqbYvWYW7fMmomX85jWQcw?=
 =?us-ascii?Q?3XqQZrd5xPQ4nn/Xnofl6j4pC+7No3TuD3kPF+LQccRPQL05RFnP5smOi4qh?=
 =?us-ascii?Q?g0aFRyioPP0uf1VBK/aayg9m6A2bxYBELkxCBlKkMKO2OFzoDU4W9DAQUEzP?=
 =?us-ascii?Q?fxwQSbumH4qoRMpR3SGOASDqwMvDFViWxvRjmG5KMuHaonLUg0RvVcJFtryK?=
 =?us-ascii?Q?8Zr5izWhs15XQzSZVjPTgm+zCaYHEd96VJNlCbXU7zuw3sSu0O6fCkzcMgoL?=
 =?us-ascii?Q?5JKc1or0IOl5NY4VM0w6GBWFPC5MbImRMcecr0XU82cF7ZZ/VA0C/FUoi8uw?=
 =?us-ascii?Q?1X6x1GhpUR2/WbaloyfFRHekI5s4fsTDPTf/qxlErejYPzov84FqKs983WSG?=
 =?us-ascii?Q?1aR6OCPOy3icVpN5CIPjriY8ISL6jwwF608X/cZb5saq/HRpChe7kpQjHRS0?=
 =?us-ascii?Q?KRC/XtAl9gcLhmbDQxlGX1jA9iaXjyi8sadwIXyYPIuD46V16DK2AbAKDkMo?=
 =?us-ascii?Q?4kBwuBqniLstGHrTPkb0XgQIkC1OV87fizBVtAbV9ct0XamJbMCBF9yl8O6L?=
 =?us-ascii?Q?0Gf5uS3hIG3VyTNtQe0GbmyG4M8VVh1poq3cMlekUh9dM9277ylsrq8o4nns?=
 =?us-ascii?Q?72tx3GRu02iUam2qyn2BzKrjvU1oVAkWNORZuAorHSNRBffI+GGt7T1V0AGR?=
 =?us-ascii?Q?zmICoTt47e3T0dYTsmMLjnBfAtVRVWLBYqGxcCMNkZM41O+nOWtLYUp0Qvf5?=
 =?us-ascii?Q?e6ubQ3AeCLm6w2I0oz7OChJ98JLv1qx3zRcKfYF5eG3G7CPO2g7noEZKfMsD?=
 =?us-ascii?Q?kx2z1idEzKE/tFVOGV/1sMEgIL9LWv8MY95muMYvkq6SfKJOFRc4UplrJGYn?=
 =?us-ascii?Q?izZDq1w/iDh8jiO/dC+/M1XhHq7l31/02+P/yAVJ7dcyan239lErOxCd0/pL?=
 =?us-ascii?Q?c4vcX6fCM5C4gtpyaJo2WXHLy9zeGDlFAjFAQOVnzfzIWXAHirewFMY1ACwo?=
 =?us-ascii?Q?ltKieGRv8vb62iKvAXoYNea/CV8bXR+N5/+vi5VqXFyRQJvhJbnpOBcwzJxz?=
 =?us-ascii?Q?NeZlqoHx+VldFP7n0M0=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(14060799003)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 16:17:56.8807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2742535-3df6-49f3-b793-08de4a1a7d96
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6264

> On 02/01/2026 15:07, Yeoreum Yun wrote:
> > This is preparation patch to use preallocated page tables
> > for linear_map_split_to_ptes().
> >
> > Define pgtable_alloc_t type for callback used by create_XXX_mapping().
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks ;)


>
> > ---
> >  arch/arm64/mm/mmu.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 8e1d80a7033e..4b4908ae189b 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -74,6 +74,8 @@ EXPORT_SYMBOL(empty_zero_page);
> >  static DEFINE_SPINLOCK(swapper_pgdir_lock);
> >  static DEFINE_MUTEX(fixmap_lock);
> >
> > +typedef phys_addr_t (pgtable_alloc_t)(enum pgtable_type);
> > +
> >  void noinstr set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
> >  {
> >  	pgd_t *fixmap_pgdp;
> > @@ -197,7 +199,7 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
> >  static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> >  			       unsigned long end, phys_addr_t phys,
> >  			       pgprot_t prot,
> > -			       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> > +			       pgtable_alloc_t pgtable_alloc,
> >  			       int flags)
> >  {
> >  	unsigned long next;
> > @@ -252,7 +254,7 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> >
> >  static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
> >  		    phys_addr_t phys, pgprot_t prot,
> > -		    phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags)
> > +		    pgtable_alloc_t pgtable_alloc, int flags)
> >  {
> >  	unsigned long next;
> >
> > @@ -292,7 +294,7 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
> >  static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
> >  			       unsigned long end, phys_addr_t phys,
> >  			       pgprot_t prot,
> > -			       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> > +			       pgtable_alloc_t pgtable_alloc,
> >  			       int flags)
> >  {
> >  	int ret;
> > @@ -349,7 +351,7 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
> >
> >  static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
> >  			  phys_addr_t phys, pgprot_t prot,
> > -			  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> > +			  pgtable_alloc_t pgtable_alloc,
> >  			  int flags)
> >  {
> >  	int ret = 0;
> > @@ -415,7 +417,7 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
> >
> >  static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
> >  			  phys_addr_t phys, pgprot_t prot,
> > -			  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> > +			  pgtable_alloc_t pgtable_alloc,
> >  			  int flags)
> >  {
> >  	int ret;
> > @@ -467,7 +469,7 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
> >  static int __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
> >  				       unsigned long virt, phys_addr_t size,
> >  				       pgprot_t prot,
> > -				       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> > +				       pgtable_alloc_t pgtable_alloc,
> >  				       int flags)
> >  {
> >  	int ret;
> > @@ -500,7 +502,7 @@ static int __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
> >  static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >  				unsigned long virt, phys_addr_t size,
> >  				pgprot_t prot,
> > -				phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> > +				pgtable_alloc_t pgtable_alloc,
> >  				int flags)
> >  {
> >  	int ret;
> > @@ -516,7 +518,7 @@ static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >  static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >  				     unsigned long virt, phys_addr_t size,
> >  				     pgprot_t prot,
> > -				     phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> > +				     pgtable_alloc_t pgtable_alloc,
> >  				     int flags)
> >  {
> >  	int ret;
>

--
Sincerely,
Yeoreum Yun

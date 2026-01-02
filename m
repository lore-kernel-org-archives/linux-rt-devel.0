Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE520299B
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767365366; cv=fail; b=lfI5Hp3s7E5znWmywWgzy8WQN5VkRsUU5YC/KipYhhvUo81kUeBS+4RFrIKZF78000U0JKbUciHOiDIBtFV0FAnZc1/XtOU/sRE9US4yeDMkvn9wCN6KvfU/HLZDl2m0GrnQdBA5UvI9x0KBzdMdHRs1qmWeb0ffZBpjXeHOQjc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767365366; c=relaxed/simple;
	bh=k+opnLqmCpD8vGwOSsriiBnNckPQ1KvqHfvHcprL+b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gwZYBU6iHG0ftS+IOsXzWmxKViGj4fepQQJM9DzQYs6CfWLR5ICNqPL0MLwPz847iilx7gfYLdjuhSYxcKxhVZ0yJsrA/mFZ5fmAE+Nhwy6PIxrIBxiibxO6yAqsAezK88pXU/k4/+AKU6OdGlFBNpet1EB9nbDpJPfpuDCs3vY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W/XjNdlR; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W/XjNdlR; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W/XjNdlR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W/XjNdlR"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rLZ4MiPXQhQx/sOjxLNK2L25+JLsYNjPyVWmJYgBKUPjIKJV21hrTZqtCYi7JqAbMT+g0qJYgj6L3BivkzCfArRGLUHW6JTZezGiJOi6/amXcR5VGFb5r9Xuf4ur+AE05cU/AHXNyGx4qbz9HdAzjJARPylj1WI72AgsLX+7H7lfT3j0JwgUYmcCpUfjEDWJV0ueL2ufYei0orwbJ+cO+nM+/Pgqr9ABxy3gTyPsAhdRp2uuTsQxIYGVTnNG23f3BwVqpuJ7i53qrgfDXV5r0zbmK2UVSYJiPXbBETrrGDWRU9dsxNdaTW8jY/tcsELSDztymkrqEDmLA0S8kt6TgA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YaQ3KzmyGXZ/KHjyB6B0Kn3COoEnWM2VcC6fppnMzY=;
 b=dspTAw+15XNg10C36tbKw5KO6OFArNXhiRj86/M6Am3Fza/NhmJLFV07xjnKtvdluKo6MYX6CFBMAMbL66UuhrA3xH/qSnWawh5iOCj5VikJB28Q00Bg2HI9MFAy8uIm1Zxeq5zACZjWkU5qVvEXvI2dF5bFojM8rD0yVEmy8MKMBhZ1dP2Rd/7rZRfUzCeAVV91JBXh7xjxoyVEUxoV3KmVLmJTTD2r3FMC5ORsh5k3/F+0dm+FNZt7s0xuGOEg+RjKQMBE+2UUPlu8n6zS6Mn6JekJP2bBF0LoW/2y5dTD/YyqMMn4kerQm2oWfV04bxm//8RalrCZO50IHGV4tw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YaQ3KzmyGXZ/KHjyB6B0Kn3COoEnWM2VcC6fppnMzY=;
 b=W/XjNdlRCsdnvG2qgqLErLYktQM7mT71NVm6vXe7Gk0sMo+fJNiAj9A2XstlJyX3U+aOkb7EZkpvuqU9ZpKBcDHH2AyCuN1wfSa+JOVB2HeLPN6517Kjrn+wbYzTxxtkjPj1GuKYermQnW+KREPKb+1uTKN6UOFY78OCvKxk8Q4=
Received: from AM9P195CA0027.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::32)
 by PAXPR08MB7525.eurprd08.prod.outlook.com (2603:10a6:102:24b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 14:49:18 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:21f:cafe::23) by AM9P195CA0027.outlook.office365.com
 (2603:10a6:20b:21f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 2
 Jan 2026 14:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Fri, 2 Jan 2026 14:49:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kj7oW52q6ixPK3t30+tPJm6prJh3IcjQwyd1XHrH/soOPjgc4W3IFl5EwcsSSN0rjL8Gsv8N6RHJrJyqhbubMYRRpdhUAq4GPQIxHwmq4H/oA05mBt1liAcLGYVOQpQmdsbNWrDUqkfMw5RWlxl15BVfJhxO8lrFkwJ6DvOxYJIP5MHKpJP+n/nQf6RSPiurDHY1H0Ncu1nqnxjGnND7MwcRpZTxiC70VjTN6/goAcXhNJ49rPzEv4AVjnAN1feBy3EtrWa2GeqxrEh+Pg18PD8asKRwzG3pj+6Ys4DdMl/TkXq5V2AToyQwW7fSAQXrFkg1EIsuQgmcrXbyHg+QAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YaQ3KzmyGXZ/KHjyB6B0Kn3COoEnWM2VcC6fppnMzY=;
 b=X3FuKdIiGZHtBDM/1NcT/APIqZGQV0qHg9dgwvjHdnWsQdUnygD57fXbMdYk3OuLkRyOy8L6CukVNsV5Z9jPZv8zwy+T1cGwievgGgiRhaOSNt7pxUlaRCQ0RkfPDqXHwQi1Us8th9c/ZH+Als0pqF3xDZjSNi9ScDo1AqJmdTVmwGKhCcrCfzTnExdt6f4QmjNX/OVs6sM+nhOiPbmabdFd+6CkNMvm3H5HmGWa4UD38SP8bBpXSX1uKhUCBsMGqiiqfR81k5s33Ak0qRCOjJnUbycAjTTM+7LPMYsnTk1AqUAVyAfgSv0TcmrPC85Jbg8CnXn/gMNNgYUThzpBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YaQ3KzmyGXZ/KHjyB6B0Kn3COoEnWM2VcC6fppnMzY=;
 b=W/XjNdlRCsdnvG2qgqLErLYktQM7mT71NVm6vXe7Gk0sMo+fJNiAj9A2XstlJyX3U+aOkb7EZkpvuqU9ZpKBcDHH2AyCuN1wfSa+JOVB2HeLPN6517Kjrn+wbYzTxxtkjPj1GuKYermQnW+KREPKb+1uTKN6UOFY78OCvKxk8Q4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by AMDPR08MB11553.eurprd08.prod.outlook.com
 (2603:10a6:20b:71c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 14:48:16 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%5]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 14:48:15 +0000
Date: Fri, 2 Jan 2026 14:48:13 +0000
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
Subject: Re: [PATCH v3 2/2] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Message-ID: <aVfaraCze9es6Vd8@e129823.arm.com>
References: <20251218194750.395301-1-yeoreum.yun@arm.com>
 <20251218194750.395301-3-yeoreum.yun@arm.com>
 <dc8b55e0-7cba-4bd2-a68b-88710c17e9aa@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8b55e0-7cba-4bd2-a68b-88710c17e9aa@arm.com>
X-ClientProxiedBy: LO6P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::13) To PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA6PR08MB10526:EE_|AMDPR08MB11553:EE_|AM3PEPF00009B9D:EE_|PAXPR08MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: d66490b8-895a-44be-c926-08de4a0e1b2d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?fFy0LvxKI/+jMaITKh/tNkpVlBPN//GId4pw807MvGbf3nLct3yuV2rKv1rD?=
 =?us-ascii?Q?iDUBw5F6V6CW3Ru05i7rzZNIij+wP7ePYFlihuxaNoPnEL7w5NrSKyDD8mFA?=
 =?us-ascii?Q?ye1LBln4Fzdtle8yoQiPieuUlaCI9yO1tpTl17R2ylLm73ahx3BgDGqPwVsx?=
 =?us-ascii?Q?H/xu3hEpXnOJPl9o5f7ARqY4/1wbPRgxU5F7bXZZa1hHzSZEhtw8MiyFnJQS?=
 =?us-ascii?Q?u0WT1KPvKLe8ua2+PRafvfrrMr1rjeqGOr1fixnjY+DkgpzUmVPlmWSFJnHi?=
 =?us-ascii?Q?tQr8bbIV3VavgsMTF33ooCWRSNW0ZjCwRmEfxxwbjA8fBwV/V5eyBW7dsjAs?=
 =?us-ascii?Q?0UCAz3YgJ2WiG1U6lh2vlRNAEsiq+697/caRIm/pwnrbSrKHEVwb3NR0fS7Z?=
 =?us-ascii?Q?lzreiSG9p49u53YNwoH1ka0H9/L706MMGHTpy/RmbU9MDR9TQv7kSHAsvJYW?=
 =?us-ascii?Q?sL0Fohhj84PZiX0qr+VpTSVf0Z/Nldlzdk9pCNdEayaofpabX3Wi06lhVnT3?=
 =?us-ascii?Q?+iYNUkewgKZ558+Ig3pMCxRge6qVYYGRlEBfoAV7DFcrmg6DH0QKgxkF1eSn?=
 =?us-ascii?Q?CXcmkVwJR5o0KyhwkuLbCIVI+eLRMh7wJFLwsMTHnlZCNgxyNzEV1UIt5taQ?=
 =?us-ascii?Q?MIjuCUhRvpuPBeu2aAvRF4MuU0OZl7NpNjTl6htwe0wfEkpwMp3c5h+OJQys?=
 =?us-ascii?Q?cxCKvPYlCt53xG8enyT22p0OCf8maiViQRHv9+1c+7vQdmvkPxg9rpx1A+S5?=
 =?us-ascii?Q?qctV2YLYp+PdpPj4p46TC+EYMMxyssuGja5PwnA6+6XgZgFiXX7INrr25ifi?=
 =?us-ascii?Q?cpohSQMlRB01g+/Bv7YBgvqOLct/iD+1uNL83JJklNamsk8rQrU+hwi6jI4v?=
 =?us-ascii?Q?XuJyaEkrx4odCVew1vGI6Y0lFVhd7FL/qpOXM4lqq+Q3l6b4WgB6mHbKffQp?=
 =?us-ascii?Q?+nFs5ZZ9oZnIdDEMWz9S4oxeg4jwiMs1jOeMxp0w/kEgWK0DuEBpKYvnii43?=
 =?us-ascii?Q?zgzIkj9l/rH5aM2DcrNE05NmRLRGtF4hO24Jnw6/CrfgetJvBw8wf4RXZb5U?=
 =?us-ascii?Q?qfodNIXe8r7C/HtDs54SZChWn/fCv2KCGTC6aQRT7/z+TF9XnpQX2frL7fxK?=
 =?us-ascii?Q?lqqwdlczk59oo7GiH4dnjjpXZTZYeiHpVKi0z5NWOHB2Pi1NpqGLHEHlYCYN?=
 =?us-ascii?Q?91lJmH+TYm8ePFOVYoD3pGRrhNxuUo4MRG+GrtykqW11VRbcvj3nzF37GoBW?=
 =?us-ascii?Q?QP9+qUK76whFcZUdTt11I9rRoHJiZN8lJRFcMvCtp8xOpJctHoGipQ+Vuon3?=
 =?us-ascii?Q?0OPdBPzecQXpWCR3sdL+DQREz3xrAc5vj7JTuGX0mtfTVmuIQ8U0Szhr7S4V?=
 =?us-ascii?Q?JyLmlPrfTKDO9/ORsgC8aZvvUDTNNLhU6TqkTIco6Oem8QL6RRgWG4r4BPrl?=
 =?us-ascii?Q?yC0Z9j0yjvMFzFjqOgUWUSuz0YNOZnym?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11553
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c3002993-caaf-470f-53b4-08de4a0df619
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|14060799003|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0moCXwzWO4SegdZ03nnUro9DDvFGutBgoOXNWV8CWFekMq316plzmo9O0tJ?=
 =?us-ascii?Q?CZ8qdcw6SF3rUYM3XrUhuZh9dEQUCWWBuuJQiNjvXffY76NXOOC5NrIlx3KQ?=
 =?us-ascii?Q?dTBfXrYjDB4xTCQUYaikDYwUFRn2FZnOw5y3UPhA5V8Io1Ra8n29ucWYuLPv?=
 =?us-ascii?Q?e4fqXU6MdGGKOhUadMGNKsxuXLTqALo1WnssNk9JHS7qblbmJrGy6+IaHOhc?=
 =?us-ascii?Q?ctauPfxT7RYFub4cdQ0fOduBRxlPx/h9ZAdd0My7yHiPCW/ui43dxfuljPOj?=
 =?us-ascii?Q?aXRCoJ+ZFh+42SV+cSqHbJEvCFIC2yHJqGKB7VD9+CiQvYnJhJYLQcS5Nlfp?=
 =?us-ascii?Q?zS9uCnrk+Ucc5yARtWSbPzHb95Qpz6KpW440ac1PSmAUFbaglvqBZjsmuBkH?=
 =?us-ascii?Q?e222aNLmLI3odZGITFL+ivBzJfbwKmEA9VhlS3tnRKN3LZ4z2lIrbDaxkxEM?=
 =?us-ascii?Q?NHm+8nStE4sMKNN6n2f1HCNMKTEkJu5Yz2FalUv4A6fJCwO8Mzyxb+pHI6+S?=
 =?us-ascii?Q?zGE/zUtpjuRe1r3tIS2Y4e8Yg5qrxvDAVco0DQYyCBgBE/eZiFZe+QHRPXMR?=
 =?us-ascii?Q?B26Bqxl95QI4HG0CYiOhaslUEQnjg+XVeNoX4byKmUTBv5VGFEz6GXdKvapR?=
 =?us-ascii?Q?SHMWfcWarlW4iE5ZsoUHWT6hjkNbkuNy96okhsDnlzykoEFl/DqUOpGvZzy/?=
 =?us-ascii?Q?EgRaY5sbCu3D7bW+4Ek7VhQqky3AtM7kWsHu8n/y+FBic/gSmeiOuxaypkKI?=
 =?us-ascii?Q?qvrUmTe2vYkVKhDmPPhp8pJVOgNAdDNu8YMIAIIST/wFqH05KShAWoqWwaDh?=
 =?us-ascii?Q?OjKCjr5kjmk9IbCptsgmU7mZRCf6COL9tGZQEYHhkat2HUSknmS7Dl5xAC+u?=
 =?us-ascii?Q?uOn5x9LLVRIlgRBXazKgVOHZX5o63zMvGL5fc8HjTHB8x3BzoHpS3bIAY3pt?=
 =?us-ascii?Q?37WyNK79AgXcyRA+iSIseszNSTf0A8Io5Y7cojH3OsP69tA53N7edQLosw2C?=
 =?us-ascii?Q?VM3mn6buVmGkHbOWgJ0F2wEaj+XvdIVZZIseHAEfG+i+lpUEGEATCg/wR8fl?=
 =?us-ascii?Q?jYY4Q0hS2bBgQHU4L/rtVcMaFPUOnZFNJA6CCbgfKX0JMxm4oCqSJbHkBf+S?=
 =?us-ascii?Q?8tp8UlrjAgBAGN1yZ260QKhFPjOJPqssjuTmz3KoJOaaNHhRyWGphDpGc2Ca?=
 =?us-ascii?Q?pEq/KQNlR6KyzLI05KRVup7abw9dEfPRmRiL95/Gk+7bM8pIFpytpjCKv+0/?=
 =?us-ascii?Q?TdjpLh9vEVqIN065GE45CWymVFw2J3lh2DiY/Dl17Ct0rtiA0en9YvD3HKCT?=
 =?us-ascii?Q?9l/Ku/sAQZ6S+O7PMn/fcLskjXIe42a1N/rj8QVKlkoIFXtgmbcTXj9C/trI?=
 =?us-ascii?Q?ZkMEvfmsZBHT/3zJQlJPgW9VJpmDHH3SC2QyKR15MCLGUXNCs+Sb7xDus4Uz?=
 =?us-ascii?Q?vhEh41rzXRaESOz8/JvEcxRr1CZCVHvHj5LGmLz8pz7K/E7jN848qs+i00I2?=
 =?us-ascii?Q?CC9xPKzo6mSgGdKTGZ5LnsmPHII7p3qPExKdp/KDLxjmXV8fheFEEs8e/FIv?=
 =?us-ascii?Q?mt/Ge7HunfUjQNugPTo=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(14060799003)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 14:49:17.8232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d66490b8-895a-44be-c926-08de4a0e1b2d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7525

Hi Ryan,

> On 18/12/2025 19:47, Yeoreum Yun wrote:
> > The current __kpti_install_ng_mappings() allocates a temporary PGD
> > while installing the NG mapping for KPTI under stop_machine(),
> > using GFP_ATOMIC.
> >
> > This is fine in the non-PREEMPT_RT case. However, it becomes a problem
> > under PREEMPT_RT because generic memory allocation/free APIs
> > (e.g., pgtable_alloc(), __get_free_pages(), etc.) cannot be invoked
> > in a non-preemptible context, except for the *_nolock() variants.
> > These generic allocators may sleep due to their use of spin_lock().
> >
> > In other words, calling __get_free_pages(), even with GFP_ATOMIC,
> > is not allowed in __kpti_install_ng_mappings(), which is executed by
> > the stopper thread where preemption is disabled under PREEMPT_RT.
> >
> > To address this, preallocate the page needed for the temporary PGD
> > before invoking __kpti_install_ng_mappings() via stop_machine().
> >
> > Fixes: 47546a1912fc ("arm64: mm: install KPTI nG mappings with MMU enabled")
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >  arch/arm64/mm/mmu.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 96a9fa505e71..9ad9612728e6 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -1369,7 +1369,7 @@ static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
> >  	return kpti_ng_temp_alloc;
> >  }
> >
> > -static int __init __kpti_install_ng_mappings(void *__unused)
> > +static int __init __kpti_install_ng_mappings(void *data)
> >  {
> >  	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
> >  	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
> > @@ -1377,10 +1377,9 @@ static int __init __kpti_install_ng_mappings(void *__unused)
> >
> >  	int cpu = smp_processor_id();
> >  	int levels = CONFIG_PGTABLE_LEVELS;
> > -	int order = order_base_2(levels);
> >  	u64 kpti_ng_temp_pgd_pa = 0;
> >  	pgd_t *kpti_ng_temp_pgd;
> > -	u64 alloc = 0;
> > +	u64 alloc = *(u64 *)data;
> >
> >  	if (levels == 5 && !pgtable_l5_enabled())
> >  		levels = 4;
> > @@ -1391,8 +1390,6 @@ static int __init __kpti_install_ng_mappings(void *__unused)
> >
> >  	if (!cpu) {
> >  		int ret;
> > -
> > -		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> >  		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
> >  		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
> >
> > @@ -1423,16 +1420,17 @@ static int __init __kpti_install_ng_mappings(void *__unused)
> >  	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
> >  	cpu_uninstall_idmap();
> >
> > -	if (!cpu) {
> > -		free_pages(alloc, order);
> > +	if (!cpu)
> >  		arm64_use_ng_mappings = true;
> > -	}
> >
> >  	return 0;
> >  }
> >
> >  void __init kpti_install_ng_mappings(void)
> >  {
> > +	int order = order_base_2(CONFIG_PGTABLE_LEVELS);
> > +	u64 alloc;
> > +
>
> nit: Restore the blank line between the variable definitioins and the logic.

Okay. I'll restore that line.

Thanks!

--
Sincerely,
Yeoreum Yun

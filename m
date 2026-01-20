Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBB2ED159
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925856; cv=fail; b=K75vq+K14GSnN3Sv39zwIAVkTQKBNXhayVoqN+BGytmCUEPmGmdQT6uTLT90uHaA61zVm7qWTnnf+rw4euUf1QqMJTTenOovp1e3DBNaIsTipdrUaFMKYqoahZB0SIetuklFE35ZSnisOBIeklnpNAynTRRFOsmfJS9gAniiPSc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925856; c=relaxed/simple;
	bh=sRQhfGWmnwvIHPwMxXchclrAJrudQhxr+RxCVFYfVCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OHZmCPhRbjM8IdJzx5kIaGrPqwCAIf1lkmKcbtKJIFkwXNTi434MBI5oaCtfzsqga9WXchQEfTlmCmwYL5DzoIB4mSVh+DXK3JPnfrxar2z3DzRnumOweRUkt7lu+O5GC/gcwx1zn2cjt3tU+6JmHbYqCpEo+PqQDXYH7Zv8Z+g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PsVjER31; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PsVjER31; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PsVjER31";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PsVjER31"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sXx1FbGqU32o8H22B3AU4WKG9QeDsllz93X5fyMYSfzTjqDcyLt8NhlbpqR6ELFs8xvkdeS92I8FvzBCgmFqCbQ1YClvf/HhFr+hMEWolgHRux2zVBhSAYbZxed+jUydWp4IhRBMqaIBquUGK7AS7ua1CdazHa1/Vf3F30HGYjJfDsmVwH0JqRJRPIDMzQkjPnQMuyyzBH9V+Vp84CM12QzNh+afXq0nC3OGBiMkTG7c1/a6aLfyUGdkU+fv92QjF1ZqIIoo5Yjfo5zpbQg0P5mKwE/khvQdfN6NeEHcvRHo0ZVDsBpQiX8yj4m9oT2QQl7QgHdQ6iUoPerLCXQnKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTD6j7yYDeDLjBNUHtIsIFCCBmxa71PIMtTyHp8sPZw=;
 b=UcHcxnIoqY/7whIM9IUGr8EjwfISv1kLahxfuPJoFU1RGB2kFgmXE+fuhuZkr4zHUIrtgMaQhOJoUQn9o32TPwtYA/NtebV6uXmiR2ZKLOcwg2AK+RGa6IJ44Ddfgys0pWzyeRlNKhuSvhSU3QL93MyUXmGv7OTh2ZOxMwy8TlTFM3JDtfyjnREfeI4KqNnsBlwQyMlvAjGj7hLb0UZaw9AVieIRapcf4fwPwz+jUCafkRpN5T2c2JyPM30EgWH2LUcpGv1m/ieyW3FrytB4OCL7kLhdSArR7iqMsBScuVp3w7/VsUReVPxyGlAsnT9CgAXyHLKjUuQI7eEhH5LlLA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTD6j7yYDeDLjBNUHtIsIFCCBmxa71PIMtTyHp8sPZw=;
 b=PsVjER31UeopKnCpD3RafsglAJZ1529B+VQoSZnMb30oinkie1WhuJFPnHTAEc9mXMBVy4ZoAk1rJUmpWuIonzR9W+8staCMdZsC53L7xltZgHx7eFLMIxL39gcKyLO4DZGEcxtmK2+2n66d4DlT46Sr6fwPrC33yiusSPddrIc=
Received: from DUZPR01CA0252.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::22) by DBAPR08MB5862.eurprd08.prod.outlook.com
 (2603:10a6:10:1ac::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Tue, 20 Jan
 2026 16:17:27 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::bc) by DUZPR01CA0252.outlook.office365.com
 (2603:10a6:10:4b5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 16:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Tue, 20 Jan 2026 16:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/FxkiEB30Ya1FowWjEv3gQHS9lJ0UtrwWZQOQNIfaOKxTAHTo8j+CEgG/GBry2qw6yHX6Iicn34i5j4PBYjjn60q8CgxBfPwY7GcERO6yqeAlng90uthoPGvuduiY6gbthMFLgfVTqRTDlVSgCuyNKf6FU2poclFQTU5QYMFIe+DuXP/VB5EyzPRRX2BYSjE8xo8xp6xq5CljbKQz5g9V/c206GsQkiWB5WhKjDnAWtL3Q4YgqiE677HTwkTPwag9jbyCgPBbIheo0/v5klCpzVQFBi9LAKipM+DbqJeV8104szWSu5/sZHrqANGRn4tM7eZTUwdS0ZiDJZYyoMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTD6j7yYDeDLjBNUHtIsIFCCBmxa71PIMtTyHp8sPZw=;
 b=hQj/qm29yBOI7ioEwc93z6fUf1GcndClcqoL8ioAops/xvHm6iqgAairuhFLihOOd4TbNMTRPV6HhD9JEDzpnUwruwJO5lnJtl5lZ9Ptr6gIpzoyvoxeGMY5QH2oeVZs1gBAEB/3Mvmvo80kdc0OBZpGTfP442hPKJgCMWRPpJmr6k9ackXtEP5g6YXLrRG5H/GHOX0PZjVggXcF3e7wnvfIecwBjzBYbiNoGpejRrT+3pCkb1QC+dgUGBtNzPPtZy62qmNTp73VLxGegD4BmHqZkl8b7KydD/FyJBQ7fUyjKLEChCKfawcJLSRuUDtJUlVVK+SMAd6Jd7ZqaXdu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTD6j7yYDeDLjBNUHtIsIFCCBmxa71PIMtTyHp8sPZw=;
 b=PsVjER31UeopKnCpD3RafsglAJZ1529B+VQoSZnMb30oinkie1WhuJFPnHTAEc9mXMBVy4ZoAk1rJUmpWuIonzR9W+8staCMdZsC53L7xltZgHx7eFLMIxL39gcKyLO4DZGEcxtmK2+2n66d4DlT46Sr6fwPrC33yiusSPddrIc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB8262.eurprd08.prod.outlook.com
 (2603:10a6:20b:551::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 16:16:23 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 16:16:23 +0000
Date: Tue, 20 Jan 2026 16:16:19 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, catalin.marinas@arm.com,
	akpm@linux-oundation.org, david@kernel.org, kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while
 splitting the linear mapping
Message-ID: <aW+qU0EHjzE9a8u8@e129823.arm.com>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck>
 <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW-k_D1Q8jpYMPoI@willie-the-truck>
X-ClientProxiedBy: LO3P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::22) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB8262:EE_|DB1PEPF000509E7:EE_|DBAPR08MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b1c6b5-5fcd-4567-7704-08de583f6796
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?aw5sgoSzZ6Bxo/11AQ42B6OcyCiCRBMqHQtTl7hqDJHRQG40vmzCuJBr8xn8?=
 =?us-ascii?Q?aWQimSf0XZB6Y508kDHDJwcYD0OVhgO40McxZcq9INUyk61TPrVWFxFwtoYs?=
 =?us-ascii?Q?7yOuOYHp3qwwL6ZxB7o1Iudn8yzTzNd2YtlmDRPO4Xj9Uf6IjmdKmEKHjZpI?=
 =?us-ascii?Q?bBo825+NUUYTfkjoZzjxYFmKXxpXr5GOL0lZjzQcj2WgcxLhVfEUh9zO6P6L?=
 =?us-ascii?Q?cHAtRJJ0H3M6epClW1RK1oznGsluAI9VT67DMBomadD8IxpUBf4CMzHxVfPL?=
 =?us-ascii?Q?qkVcSlueEdQDQK9fVS8R4gCwsrBOT2ie/S5Sn/aINQ5Gmvh0AL0/fHVC7M2M?=
 =?us-ascii?Q?0E3M6wmSZnC78nXTeq1jPHxFH34YC1mL+dZMZhAEQPNnEbzqkLHxsPXgcJwj?=
 =?us-ascii?Q?kbRf/nVQHqfi6SsbPJmtUmXY+Cm3LiiMDzrDRe8p80z4a7m7ZRpiZOA5tkoy?=
 =?us-ascii?Q?FtVmGOZ0bhqqoAGeizB65Jyb+qgUH3G8tLQFzcknMTQ2BzT352O+tPWevkAF?=
 =?us-ascii?Q?WG1dGNhPU0gpkShMMzxqBtJJibxPmsYfSke7vVmR2iGvXYlHUA/+tVV2UHJX?=
 =?us-ascii?Q?No7ax1/gweOnSUl9HGZg0b8YavCCCFEzX8gf8U8IW9zfIlQpRUKVyYcy3Sk6?=
 =?us-ascii?Q?DCzEPv6oM+UZTG/Z7+L4EnKQO91QKC5MsO6efp4UTL077nMXBEar6/T5hD4k?=
 =?us-ascii?Q?aYSDRP51jYp4gNgnsWjHq9Mf0GJdhKChO472s/jV5+r347R/38wlkaHxE9zV?=
 =?us-ascii?Q?fWxg4ovpjWcwkhj/2Nz2x2tg99rToiPLz3MoJztob4Ty3FINsvkHN68X/Kn0?=
 =?us-ascii?Q?s62dzepDMdwfOYIzUgAw9Mu84JiQr3pfivFXF8DvDGW65CWEZvkiRIg8qst6?=
 =?us-ascii?Q?Fa/PUTGRe2XmTtmh37hF1d7EpS0UP2GPROS+XXw1LoRiLdGo4Ud5YSlNmMCv?=
 =?us-ascii?Q?damp7HfDpZCpCWM1ZSWDEJnfisGQe6loaFao3n8clBU+shEnNfo8DBK0hvIm?=
 =?us-ascii?Q?cxiaIAvPke9Wew1wxD0JzA48rEtwkOCfdEco+107pbvTwCXk0Eq+FjdESFFv?=
 =?us-ascii?Q?eSe5kDb/oAqGZu76tt/6mMCv27ahH40Z49hVJOB+ERRks9DQ2RG4qwEexiLd?=
 =?us-ascii?Q?7hiC90L0a5H0GEhyEArwRSJnJ5gZeqOoK/OMShre+ZEaSLi9iVNipvLWIcmx?=
 =?us-ascii?Q?C4+9UmqSb8iQ56eU6GlJT1F3zSzmdxkK9AX43t4dfCq3SzTyYtk7hqptn7wQ?=
 =?us-ascii?Q?VcfeR9UJ/XWhplo2V96OxnTI34KTJ5fSVqtRSfssWC9H/Yn5MQDSloAVynvU?=
 =?us-ascii?Q?ZB1hTMNtX5UxNEc5XuXsH2C5OQY9L7/pjscINorH/OhKO8RHNIgREdYG33sD?=
 =?us-ascii?Q?EwhvNGY3web63g1+3AqYGdWAyyjXJaSvwcezKMz1I4vLiOAZi0IkskT57/zy?=
 =?us-ascii?Q?1BEH3l1lu649b3QAkCQpxiCPT5i/IksEUArY36I9NefZgVTvqpF/pumYzzhT?=
 =?us-ascii?Q?R7uS3TwxGIDNdrcbSE9kNacfGLBJr1Ubky3wGqaaILKYJU5ccM8B0IktIpyL?=
 =?us-ascii?Q?g6pak/m8lzBBhSBTrVyjyfOIxqVCOGhto8+YMkx3?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8262
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c9a0813f-45ce-47a3-b4d4-08de583f411b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|14060799003|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ME+aikS+Dr+oNfn39sDuwBSTEsx1TK2au6CzchwzOR/RIsZRTpZ7vE8p0Gj5?=
 =?us-ascii?Q?ObE7iIa2b/+sFEMndhuIZ4A7CpbNaOT+lyZ5emBmN0Mo+2+sgimcqYlMNsAv?=
 =?us-ascii?Q?mx7mjVxppfkNrfA8A0miljeHkBsr1oZ8BNUlXL0VNxCBdGS5bCAXKz+Yw85a?=
 =?us-ascii?Q?AXiCJ1w/fDnSuzvak+qRdNiyk400CGtn9e87ivfJ/CcjO98PQnepMoOPPsz/?=
 =?us-ascii?Q?rm2su2njO+tH4X+GvEWp+gz1yKDy7R6/OfHXsfGbXTShypPtghY6HxkkcIcx?=
 =?us-ascii?Q?tKMx84ArnKGJcZLdueuuDdDkd5+I0TEZ5jxf2KquEoq0zFmYsHzHHVqjiXI5?=
 =?us-ascii?Q?LYsmEflZNT/Um04sQxOrs4MTdYruTiQjY6dQLzaLigZZvIUOr13I27fCxb6c?=
 =?us-ascii?Q?N0LC5CNo97MuQqpV/xftI/9rKUahplg8z8L99LLGPXj6H/TWzLVtDkVfc7wO?=
 =?us-ascii?Q?oKfozjaN2WlEZF8wvEm+9oAChLmzva/yi5Icw5NO8dgvQqdR/QbsCtNnQKeQ?=
 =?us-ascii?Q?cTfxax4+GWhvI6eVfKYCKPN0MzkvAKzR0rak8ZtviBELzjh95WvaoSz9WGKw?=
 =?us-ascii?Q?Ra8ksljNV7m64ugU3mETbtg7vxtebKLyU0XN8WFcJXsVyGeNJ4/zOJnolAqq?=
 =?us-ascii?Q?ylbVQQ7y51kiEMjAL4q2SXamBEwc6FuGI20FYYLd7BnV1xw0CYl4Jmx6i+kP?=
 =?us-ascii?Q?3lLeCUbcmUMShP3Pd8w57a43nTi9OlCZjd1ugpxlKv357mA6vsrnl6frzaWg?=
 =?us-ascii?Q?ptz1CuLbqVdZKAS/b9tfbsEv4LfQ1tB5gZyVeDP3WOxa0h1lpg4AqAkAaES5?=
 =?us-ascii?Q?Rstqw3c5zAL1Hn2RMIGkh+DRAJQ7mAkApVV+ha9KYpmllc1y/cR+8CJbuYgV?=
 =?us-ascii?Q?D1TRxd/hLuFcs7pKjtB6o0Ig7i1y9tX/gsJ5J8x/zG7OQT6Rz93NvBn4cDg3?=
 =?us-ascii?Q?JSnRsgmGiLHGCmXeN5OrugLaKzoMo8rsALDqD4FLgN+cNXBQJS9aMO7/LKNR?=
 =?us-ascii?Q?AmN/Uc7Obu7EUh4nBwAbotnCeH98tUCpJHyblZg3jzgpu7h0ek2PoPnizoZc?=
 =?us-ascii?Q?2dkwa0vP7Hfj66keDaZm4b6qWCJAhjgkyR+yOtXnUadjR7Koyxd3Po24drS8?=
 =?us-ascii?Q?sNQIfG7Yt59JlPENNfcNPhikXqZsfmkgLFZgtQEKTIiAadWmJ2hSeGINvhOO?=
 =?us-ascii?Q?LndTIuRaPizDdWJM/ppvNKYmX6mCppSXccz3kVVsL24GxtUkOLp+8FNXbEms?=
 =?us-ascii?Q?kgswXKpGvM+jcYYHGKxPlX3RR8u4B+0tiQb6CCNPisjn6QQw0OUiQwIFRuob?=
 =?us-ascii?Q?gdYjWWq6R+q4TKfc6mPH8Pi2ILIEYYTnfLtUximsbMN4MzBJ8pkZJDyaaTNk?=
 =?us-ascii?Q?XoeBvNw9fVoOELIkFCuSZYjf96yMR0DmiQxK9pktqsnqiFjfBW7x933J93CW?=
 =?us-ascii?Q?YlaZH/a2gWF0D+NoAe/TVPCz+fRFBv9tUJaNHCZDmRNhETecxiLhQ/SKkRG+?=
 =?us-ascii?Q?A6lkopaiUo/eSGTp6wQJ59su+TmpJ2lDfWnxyZP/QWnipYmNgGYe/dyn1ZOh?=
 =?us-ascii?Q?o/rC1Eukf4Yd8dxUQVbW3R/3D+BJclkI7wS1ATzctpo1vVIxhhKXWZJAv8wH?=
 =?us-ascii?Q?2eBKEiRK3+gsJq6PL1sUJJKdzXA9VnWlsxJxgm8w9jWRBQLbALRFax7KxotT?=
 =?us-ascii?Q?u94zL6X6XBX9eGfwaSkLJhT/Wa8=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(14060799003)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:17:27.6162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b1c6b5-5fcd-4567-7704-08de583f6796
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5862

Hi Will,

> > On 20/01/2026 09:29, Yeoreum Yun wrote:
> > > Hi Ryan
> > >> On 19/01/2026 21:24, Yeoreum Yun wrote:
> > >>> Hi Will,
> > >>>
> > >>>> On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
> > >>>>> +static int __init linear_map_prealloc_split_pgtables(void)
> > >>>>> +{
> > >>>>> +	int ret, i;
> > >>>>> +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> > >>>>> +	unsigned long lend = PAGE_END;
> > >>>>> +	unsigned long kstart = (unsigned long)lm_alias(_stext);
> > >>>>> +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
> > >>>>> +
> > >>>>> +	const struct mm_walk_ops collect_to_split_ops = {
> > >>>>> +		.pud_entry	= collect_to_split_pud_entry,
> > >>>>> +		.pmd_entry	= collect_to_split_pmd_entry
> > >>>>> +	};
> > >>>>
> > >>>> Why do we need to rewalk the page-table here instead of collating the
> > >>>> number of block mappings we put down when creating the linear map in
> > >>>> the first place?
> > >>
> > >> That's a good point; perhaps we can reuse the counters that this series introduces?
> > >>
> > >> https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/
> > >>
> > >>>
> > >>> First, linear alias of the [_text, __init_begin) is not a target for
> > >>> the split and it also seems strange to me to add code inside alloc_init_XXX()
> > >>> that both checks an address range and counts to get the number of block mappings.
> > >>>
> > >>> Second, for a future feature,
> > >>> I hope to add some code to split "specfic" area to be spilt e.x)
> > >>> to set a specific pkey for specific area.
> > >>
> > >> Could you give more detail on this? My working assumption is that either the
> > >> system supports BBML2 or it doesn't. If it doesn't, we need to split the whole
> > >> linear map. If it does, we already have logic to split parts of the linear map
> > >> when needed.
> > >
> > > This is not for a linear mapping case. but for a "kernel text area".
> > > As a draft, I want to mark some of kernel code can executable
> > > both kernel and eBPF program.
> > > (I'm trying to make eBPF program non-executable kernel code directly
> > > with POE feature).
> > > For this "executable area" both of kernel and eBPF program
> > > -- typical example is exception entry, It need to split that specific
> > > range and mark them with special POE index.
> >
> > Ahh yes, I recall you mentioning this a while back (although I confess all the
> > deatils have fallen out of my head). You'd need to make sure you're definitely
> > not splitting an area of text that the secondary CPUs are executing while they
> > are being held in the pen, since at least one of those CPUs doesn't support BBML2.
> >
> > >
> > >>
> > >>>
> > >>> In this case, it's useful to rewalk the page-table with the specific
> > >>> range to get the number of block mapping.
> > >>>
> > >>>>
> > >>>>> +	split_pgtables_idx = 0;
> > >>>>> +	split_pgtables_count = 0;
> > >>>>> +
> > >>>>> +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> > >>>>> +						    &collect_to_split_ops,
> > >>>>> +						    NULL, NULL);
> > >>>>> +	if (!ret)
> > >>>>> +		ret = walk_kernel_page_table_range_lockless(kend, lend,
> > >>>>> +							    &collect_to_split_ops,
> > >>>>> +							    NULL, NULL);
> > >>>>> +	if (ret || !split_pgtables_count)
> > >>>>> +		goto error;
>
> Just noticed this, but why do we check '!split_pgtables_count' here?
> if the page-table is already somehow mapped at page granularity, that
> doesn't necessarily sound like a fatal error to me.

!split_pgtables_count is not a "error" case, but just to skip
the remaining logic.
Might the label name "error" makes you confused?

>
> > >>>>> +
> > >>>>> +	ret = -ENOMEM;
> > >>>>> +
> > >>>>> +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
> > >>>>> +				  GFP_KERNEL | __GFP_ZERO);
> > >>>>> +	if (!split_pgtables)
> > >>>>> +		goto error;
> > >>>>> +
> > >>>>> +	for (i = 0; i < split_pgtables_count; i++) {
> > >>>>> +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
> > >>>>> +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> > >>>>> +		if (!split_pgtables[i])
> > >>>>> +			goto error;
> > >>>>
> > >>>> This looks potentially expensive on the boot path and only gets worse as
> > >>>> the amount of memory grows. Maybe we should predicate this preallocation
> > >>>> on preempt-rt?
> > >>>
> > >>> Agree. then I'll apply pre-allocation with PREEMPT_RT only.
> > >>
> > >> I guess I'm missing something obvious but I don't understand the problem here...
> > >> We are only deferring the allocation of all these pgtables, so the cost is
> > >> neutral surely? Had we correctly guessed that the system doesn't support BBML2
> > >> earlier, we would have had to allocate all these pgtables earlier.
> > >>
> > >> Another way to look at it is that we are still allocating the same number of
> > >> pgtables in the existing fallback path, it's just that we are doing it inside
> > >> the stop_machine().
> > >>
> > >> My vote would be _not_ to have a separate path for PREEMPT_RT, which will end up
> > >> with significantly less testing...
> > >
> > > IIUC, Will's mention is additional memory allocation for
> > > "split_pgtables" where saved "pre-allocate" page tables.
> > > As the memory increase, definitely this size would increase the cost.
> >
> > Err, so you're referring to the extra kvmalloc()? I don't think that's a big
> > deal is it? you get 512 pointers per page. So the amortized cost is 1/512= 0.2%?
>
> Right, it was the page-table pages I was worried about not the array of
> pointers.
>
> > I suspect we have both misunderstood Will's point...
>
> I probably just got confused by linear_map_free_split_pgtables() as it
> has logic to free unused page-table pages between 'split_pgtables_idx'
> and 'split_pgtables_count', implying that we can over-allocate.
>
> If that is only needed for the error path in
> linear_map_prealloc_split_pgtables(), then perhaps that part should be
> inlined to deal with the case where we fail to allocate part way through.
>
> Will

This is not for the case of "over-allocate" at the first time.
But for a some case that another CPU caused a split between figuring
out the required number of tables and actually doing the full split
(though it seems unlikely) which Ryan point out in here:
  - https://lore.kernel.org/all/73ced1db-a2e2-49ea-927e-9fc4a30e771e@arm.com/

So, it's also required for case of success too.

--
Sincerely,
Yeoreum Yun

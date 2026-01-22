Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D8246BA7
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087321; cv=fail; b=d4juEgcqIMkESeRGvH9QS5I8u9pvar1GyhMkLzo74J+3C/WHZeqsqGB/2T40LdSkLhzTfUFju/gMA3sRpQgTdjCmB7w3e0FWfLtxbLb4QODP3AQRug9l0WLqrozsvKe640Ub7z4jD3l0+ChQICUib86fh/ukayJn5Mob8PFQhuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087321; c=relaxed/simple;
	bh=sUkjaCa6toHSswSYI+mxcCaWxDnqckksoWHBHEMtEyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jRS7IqdXhX0xDezzZAsDLqGEXTTl0Nyzom9VNSgp/OtrJMRZhfj2VI0+62pdpDyZ8jErnKZ7lcEMlSUlvfJVACbjfNadRYXSGurLgApOrFX2bR2JWEQ6KbbZLJwERyZTxh/VZr3UmpIiV0FFU7JT07M1cSaTe9JZhv+aUMuWDTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T6PIHDkU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f8I8npbz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T6PIHDkU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f8I8npbz"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LLrHIN421006;
	Thu, 22 Jan 2026 13:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sUkjaCa6toHSswSYI+
	mxcCaWxDnqckksoWHBHEMtEyI=; b=T6PIHDkUKKLBlLobRQMGmlWjvlm7eUaDsw
	/OBLp8eiHfrcHSfbsb0pBOc1NY846TxWG3yfo6L+mKe8Srq6rcXpzQstmYO9k5LP
	D7gUVdjXvhVCPueXHnUelFZp1QaX1JbvsXMkpzyKzWSkLCPBvvFzbwz7QM/eykxM
	53mMMpsamdWAT0mxlnO6y79KKc2utz9Tt1ITHoeBprJpPW/ms2OpTAlpZqmKwaZi
	C/yJBhir081dxt+yK6BUVhqoiXy9fiZ4shZ5wh7g27oViP41BYPDXftAKnJHHdrf
	SspVRMNa2qyLdX38guneSpKe7KwyToe2U7n2jd9NqugAUuxQ4Jzw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcv89u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 13:08:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MB5bRN038732;
	Thu, 22 Jan 2026 13:08:06 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcs42s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 13:08:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0ayEskxx9cnF/rAn6G0yWmy4bU831BV2ibAta4oOZxZSUH5vqsAHOUhrg48CxdSf7VCSRiX/ggPGKkD9p8snqaY3+NwvMANbNpJ5B5L5hXkrg2HaBy04y1/rvONH+F7GXeJYN0obS9tVZRssh84piA5Eec8euQ3HeNEIXT3I4GiKBKTyqVmxbUgsEqHbm/TQGevUR5HGWteNLZcdOpSvKc4gaGgMfuGA5rwpHAowUI42UATB7D6JwTKcSB5EtH2M73wgdj6UEHT8ScmwMf5R4OIIrRUGBSnQ9QD8etyAUT/ybtf7ID7tqar2CfoKHKG7PQIwWYxmXytSuRVj265YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUkjaCa6toHSswSYI+mxcCaWxDnqckksoWHBHEMtEyI=;
 b=NIVlEyFcFxkAc5GwERmuuKduE76PCdlr/GL1y9UXOZZzPLjX2MJWWAsXWUIBbACs4VNJ/RbWlyD7vGQnC0UfRkchq9DW1VrhcFdAu6K8Ye3jdji5tDV33XmVH3/bJeBXylI8BMgJ8Bcx6u1i5wdLkzWDejTUJvenbzqlM/3HA+THPnXyeAidHJK8iJv704L5QAlOyoSn55lBWPTwUO7DZeELwf/6PVbPBQYRjxX3BpZ+UPtDE3oVueNWZNUKd8WdoV7SzYuAilyqi+yofTv9AqxCGCzLeoM4Xxskksj0LOrE7J7tb/KsLzrUqN9ilMHL3gmBmFa9HVjS9LNWNaGPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUkjaCa6toHSswSYI+mxcCaWxDnqckksoWHBHEMtEyI=;
 b=f8I8npbzzOj+nIgK3zZUkEU7qlJoFSjktGZ3pl7eQJs5gdWzzvnMsLjT0EeChuHY/OUx1kulKfWx6E3iyQJals2hE0ss4K8LJrMNeL+Fw39i0Oog3ix19lf6H3Y97BJS1rcgi8V5lBJUEIpldZGQS2NA6+H6BaRC5ZNQqo8pKkk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 13:08:02 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 13:08:02 +0000
Date: Thu, 22 Jan 2026 13:08:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 06/10] mm/vma: clean up __vma_enter/exit_locked()
Message-ID: <e11b84b8-8493-4469-8b53-129923f31209@lucifer.local>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <f1981963e3c9421b6ffef19f15d87953895cd0b5.1769086312.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1981963e3c9421b6ffef19f15d87953895cd0b5.1769086312.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::17) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH8PR10MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d862de9-227e-4fd5-cf47-08de59b7460b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IcvDzbwpiYfjwuKYFxf1K2MKH8eSvG6Sx8a1iU+dypfqMmejxvDBlCtDj9/W?=
 =?us-ascii?Q?87jdGUswhV1Xf7J8h9jYQtiioQqtCHw/bzv4nhYwlU5p8grcfswdg3fCVWhp?=
 =?us-ascii?Q?NM+k5/nwn/IphCzrZ6nbKlgS0R13n3lmOE3t7sL+8d/VLRzMBWMQX6GVYqhS?=
 =?us-ascii?Q?eGiUEAmRiQKf0CFFu9hkoUSJN38gINArPMXNFbgUjxxvUadX0ll8eudRGLzj?=
 =?us-ascii?Q?4I7I65lWp/eOI9YOqjIAiii2I+Ee82V6n0o37bDcXe3xk9lDoQWptertT5hx?=
 =?us-ascii?Q?A+NHz7sTLVnHV7O47ivIlu/p3SVU6JvQSV9nAjOco72rFvVUDA88Y0lv//7w?=
 =?us-ascii?Q?3AokcZ9Z0j7xUtjK0sxw4fLtmOQRrJzxXDJYIPPg+0GWZyam93bsSOPJ2xDx?=
 =?us-ascii?Q?1cVEmuJqGR5vkQALw0iVnsODLSjio+QVZXEpeybtq/7qdcdSefcuC1fnLtIh?=
 =?us-ascii?Q?dpDjNL/vuZnLlCyJmHRYqKYI0idHnSzpnzrQWgVl7cAKd6IN/+mCwxS9KRZ8?=
 =?us-ascii?Q?DeKO3nft7P2Zv4MtfdiZLVOluy1VgNdkcJCy6/Emwqk+v6GhaKjsBXtrI6+e?=
 =?us-ascii?Q?YkqV1+OtetRQSZvnJ/LSl5tU5M1iZdfgZDZYe9lRMNqu5Plhd+Pae8RQiUTP?=
 =?us-ascii?Q?s6Dnviz0I/Zm78WYbm45KHN/OT8uts1CUs5GFeR6kVIxTMwm7f0V9DH7vDK4?=
 =?us-ascii?Q?iNHLxPepju94mfgiCDhI45xbmB8AeqtxXqn7jzkd1zfixRe4eRjFWlA0YbKS?=
 =?us-ascii?Q?+fiqMR7jCwA8m6ob6/4k+19A/0g/S4YXDynlwigN1o2a4CBlWn4+t/83Sjsv?=
 =?us-ascii?Q?eggD0i3FcmXQf1pfHtpsIwA2wMGxOn7Ozx9Gh/l6u4uXz0udP8gz8oLk6XC8?=
 =?us-ascii?Q?3o1iIFndrv8ibINMQeugkWFQLK2Zv0zzzxXzxZogC2DvJlcpsGu66WJlk0YK?=
 =?us-ascii?Q?dvbDfI4ILTIO4t3l7fbKUSzQ7LriDQ3uoQ5HkdqF1UduhLMfzf6nADpBv4Ds?=
 =?us-ascii?Q?x3S2K09n3HBV0W1BXzq0KsXPn6L8iIs/Mgx+V6Xt/a09SNxrn4ZU19i/dCzV?=
 =?us-ascii?Q?ZWo1KFzXA24Gbh8pBN9p+1rU1/QieX+Z54CDbBO5GmP9GuuLoyapUq/aUIny?=
 =?us-ascii?Q?74kCUoUkydGO+r9mjV8fvpsgEVInayoaCtziUN3dPnAyC2cHX2Ae/FhI4oc0?=
 =?us-ascii?Q?Anw3rqnUkteez3D/hlHL7mS4EckC2lyDur1xEa1qvmQ5tPknH43+EQMxBJyw?=
 =?us-ascii?Q?PN2XEg5Q9pgJMoLooh/FmwlDCtLNkGHPJk0NYWski53pO4Z/p5+xbsL1iPvG?=
 =?us-ascii?Q?t9q6Kzk7DrUgG0sl+V4CKNbILGzGpITlXHeuCiqn6FpvTMY4dxF5P//6Qcfo?=
 =?us-ascii?Q?aQF/Mz6RE7g2m+FsA/axxhwohyULthTaqB2Xni9pO1KvHvkh4/mPBctKLbO0?=
 =?us-ascii?Q?X3Ujdoy5qk1xUW9/YKpXW1RtPgwXsyusEWb4nzhLsupVoz41lhneB+YOFgYE?=
 =?us-ascii?Q?ukHknmEpCezYYt9XI6nt083CK0QQ6S4adqws6Pg0F1nTW6CqxDGn8yRIXP3B?=
 =?us-ascii?Q?PvGmbOK9Stp1N6RLe3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+myjwxaOD53Fcc8p6g8lFiNKQUskFcchQ7etHy/rnZ4xdLovZZJ2GEpkDO5M?=
 =?us-ascii?Q?61OIcaN2+SDUsSHgUaKb836A/Pr8h7fUs63kBYz0WtTYIfjZS/P+FpSeEkQt?=
 =?us-ascii?Q?J7jEonZGks7GHv/NhvvIWPufb/DJDYlLIrPiIbHvaFXJmV5KW3UO3fTbQbKb?=
 =?us-ascii?Q?n0dSSO5BG4x3Uatl/97Oaz4PIsc4QYTW0N0qasI3OhMpMyDxwY4gvXO4WDoM?=
 =?us-ascii?Q?MF2Pnmdr1/g8w2p4eOrX16j69+DL5Zi398EBF/fFhZc3e25Tro261aCNe9cU?=
 =?us-ascii?Q?1fzj35x2DeU2Ag1LmGfznb56F7f3JzHLqBguwoc3CNUKtUwpjz/a8YjxQ8j7?=
 =?us-ascii?Q?IAuuCIzNuScVhh+eftyNsx9bpBhdbLqFWQ8zdWG++9PKREZVff6+OHF30+Ju?=
 =?us-ascii?Q?m7VSCdzGUYd3Hn6GnGRTj3e62y/xJKHaea1iFNPxRCcmOm5Mkh8GwQcJMe0w?=
 =?us-ascii?Q?C7eHWTsMm37XVA12th+gmKxwgrroZ8eEJ60d9z89ieP/FcA2eE9vyKNWS8eW?=
 =?us-ascii?Q?b2+scsfOyrcZz9+9xMZAVcuwa1itSvNp6IKVcT6aMyTGryK5AuaLMzkTMnad?=
 =?us-ascii?Q?vvuDFzoBlZcrSI+fFc7P5ZP7ZWoaUtpfsA4yJGeHZuqq5MDddqGGVehGiDWZ?=
 =?us-ascii?Q?c0DpyUZY5TfZF2JgHTk41ZKuRGoMmI8V3CB1b0oz7TNPLzX/YDuMIahEuZxV?=
 =?us-ascii?Q?q0cU4YEYLl36a7+y2u+miyRJyOOgVkXaiM+WvfKk7kZ0DyXCnlzqRyMurN7t?=
 =?us-ascii?Q?TLL0JIIKM+vTRznp2lelry2RxiiepX8tv0FalcR/RPF2PfFXkPdOR1SEF65x?=
 =?us-ascii?Q?iGCPcmADQO9b6Ahw2s6nwsPKlD7Akfo4MIcQzp/q95aLoR4tA6e1/lBaLIp3?=
 =?us-ascii?Q?BXOMfXyNGX51sUGfeBPEDxbD1dymWCD6AF6xjj5VHgm2r0oAHVqN7VZDvNde?=
 =?us-ascii?Q?7YW0wRgUX8x/vE7qnam9quYg4xxMLK8/sfn867MYnZF5gjdyCgPLcRHGutJ2?=
 =?us-ascii?Q?H7NWGwjW2AdstzuoisQRnlKyLIAstYsuJPC22oxOqnLsulYFYirSHeVRFC25?=
 =?us-ascii?Q?8ghH02HxmN5d5+ClihaC3AK2m20nWI3y947UXuw21CD1uZB7aSPnEgTRQ5eB?=
 =?us-ascii?Q?YPyr+jH1JQ0K4baewtD/+Jv7MbtT6LqgssOESew510DsqCD67Fv5L3TqCL9I?=
 =?us-ascii?Q?LGecjwsMKzZIOrwCLKScIwWQWiRcJuvOVz+CWhEp+lyKQWutLfy6ovMDYBny?=
 =?us-ascii?Q?htcP+tCVVFHg9O0/5zhkQhDXpR9n6dsa46euvafyrq6AvBuXBK6K9tFJ6kO7?=
 =?us-ascii?Q?ux+ZpJccSrSG2SO03hrLTelD7cDY1L5oMTD6yISe1vd5nlGbz0+VJVqZaKdN?=
 =?us-ascii?Q?lGKpqjp6m229Auf2JUKTTxwlw0JynY9c0mVdfkkUSppz1f19FOk7k7E8HbGB?=
 =?us-ascii?Q?AMuAuVc6FfzWwqoQG+2ntP5CfPE9ZrGqzZu+f51Doo5FgUrLvnbClY0nWPDB?=
 =?us-ascii?Q?3hw55fz0BKRuxRM93a6e83Y/aMdFdxysE8i59e1j0NehYrXXNXkPsfZjTmMq?=
 =?us-ascii?Q?C5F2R9eD7cYhoFXZ/GW6heQ7Z4sn4dva4NXtJQVkjggU7fFurrnVhTxVt4P4?=
 =?us-ascii?Q?7GAIMD1u5uPG/lrn/d2cm40JZnLbavqXxLQ1GptH3C5qE2iRpOLamLBf8COR?=
 =?us-ascii?Q?fYNbnD0x6vnz8vbrkl61Q3/u6clo72B0JhGr5ZBKVOsOLrqVt6Q0rXgN6k/c?=
 =?us-ascii?Q?IB1CykA7l0CmTgLoNmfda0WwJOUyFgk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CE0xwbN1iKzZD30aC/J4RxxEkTadpwcjn5d/Y5SpjBVyC3vg1nf5gI8oyUahtzULQ7Ee1lDmZD8dkrnWGT7hU3i0GelLNOpO3D6IF9WaDAegR9O6qs2Co2kPUQ6yrX4b7ZnWsUZGUABljO9IEBs+yVSeHurCk0S0f1/c15QV/VFOJmN9k9wBQRnJ2ZjOp21/yca23pMOeh6orsSHKilnQQgok3o62aRWvlqp1k7Uhi8r378VsmGjkQS5JRk3Z4DByApwaOdYSF7vzSAsU/X3mQOqj+5bJ9EsirSxc0hyxk/H3yI4exp8cOIwF/8pVQcxTb8r86f8c3UFdjngSXhjfjkM5YfAK8WzViYkLIbFF4wNTtkwKFhxkzhi8oq4rsjQo7vp89YfcJBMO6+w80j4SXJpZkXTVNOB7+AyUt9fXf9SAmlGfq2lpjL5kwfnljoc4yS8bGMYiGRqyuiY0Ei0g7v1iwqnStN+u202FCNMEVbQkSLTkekUf/URbfl3igjAw9AQvlTdaMIyPgVmUtxHkVCGYU0yIRkgUsJJSjZ+7bIYaotwqNHWQ4BDwNzgRqZzCWy14ALs6eGZ1r3cBQL//aFOhvVww3AGDpeYxQVDxd4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d862de9-227e-4fd5-cf47-08de59b7460b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:08:02.2923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQLRA357IW+bTrEVHNrT8xmyXUCdgu8NKPy5+zarY8lvQlXqjGSJPeSy3nJwfVXrNpKHdkn3pZgWSAAxZVtByxesctgg+Nn+kRy8saZBfcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=678 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220098
X-Proofpoint-ORIG-GUID: 9tHEGIVHeFke6CEOY-8n-K5zEhud-y0T
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=69722137 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=v1pD9O3XdP_JaNK95icA:9 a=CjuIK1q_8ugA:10 a=Qzt0FRFQUfIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA5NiBTYWx0ZWRfXwjkZcqYSaLba
 dwbWKluMPZizi0DxmORidSApI5WT3TuEX9v52CopcUrzopDYekQwyGFmDhCLRqP7rk60AIxYewB
 VKxrZylJsD1XsKMril6sK6wc6qM9SFmo0S/NctECa4pqbTDUGUS9q4n/CzhTJw4s28hEjr33EIx
 fwZMOl+0G2iCzkr/t8tNO9j/gBObygQq9qTdjWEYiqxMtN2JlnhHVRRMGBIRiX/PzpFGyojWFFe
 9Msm5mjc+56CkfmXzb2AEIZHz+2B8qAg15h06FZOGCSop9VjxcpBGv0x8byJfyLvBMIX87xOVAc
 cKDFFlCrOprnn/6EFST+dGB4+Aq0JkiLIkLuVQTPn6l9hn5Xk2aA5ttrQzo9rjYgkqm1QSqF2/o
 2+3Rr6nXb9qeZnAQ+3HLiA8WoFX2WxnurVUPz6tGUQVoF+iMJau0PLon1DBvHN3fcASDCkVjkNQ
 zd8erFq2NR7qVgW76uQ==
X-Proofpoint-GUID: 9tHEGIVHeFke6CEOY-8n-K5zEhud-y0T

I'm clearly cursed today... but obviously this is the RESEND 6/10 :)

Andrew - can you check to make sure I didn't confuse your scripts? Apologies for
this!

Cheers, Lorenzo

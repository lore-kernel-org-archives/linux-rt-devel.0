Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA972D73BC
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199187; cv=fail; b=VkzSj3jm/BGg/l20XZ7Cr185Y2FJXoKaVrCLH7K3q51Y7MN8gCcD4cwU88oY1t5SVL8SmdeBh2Ba52G3XhO3ETzg6yU78RWMyDQQOweAM/J+IngjYYTIgmqI2Ksl4Fy138JN3PyCuQ13eJQtENQzHrFemVZMzgPIGtTEn44HaAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199187; c=relaxed/simple;
	bh=XGlhIor/KumD8srlk+w/H171+pccvRFsn0B3pGMdKeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WhDSbqtS/Lf/Lc91rEworlDu/Cs3cOwr6bhkRNiRLzPwoXhYkvZ0uidRB7kmkhR7wReb+0IgwD27KJ294exjx31X3YqC1pb+CQB/DIJ0k1xarSODLa5yLIQ2KiIu+ykf5Ws87f/TvrGGTOxa+xv9EwKMDXMsSy7uQc2oKk+HaFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FDSeldMW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kWbBOZdR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FDSeldMW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kWbBOZdR"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NF7e9H2973460;
	Fri, 23 Jan 2026 20:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=47gDud7KbvmsdvrL1+IOi+cZg98jjbixyWYKeeebeak=; b=
	FDSeldMWE47xWGSzfOb7Fts7Kn9i4zNKx50sMitY3O8P4IEbtgRFAFEuH0BcaRcG
	jKyAyehVLwpFrWgGQ68wbjruUkqLZp7gF1BkuDsTkO6Nj67kDG5+IagHwhVgXPMm
	hLaCGeAyOadEwzucfmzGQzh1X4V7+Uot3wqne9PwHv6qaMdsyC96taYDeaentUDk
	u5RtM5cgs+eTY8FHZSeE/P+Pc/AvJb7rmEaKdXaWmXWhihxzyLgSKoajF5u/pryl
	KP/GyUskdkE7Ctt+kyJVXMokMuv9yCbtQ2FE3wrQI3gTrkThlbgmnTV7QFmpe7a2
	PR4527U4I7fmHXdVp++WYA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcynpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 20:12:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NJ0iOe022514;
	Fri, 23 Jan 2026 20:12:44 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vjmh1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 20:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJyINRMq/YYlObKgtaE9aZKQDT9k17YD+bv7iatIuthwbt90PFZUBpxB6fX5qraajFAVlnuuLKbSokzXi9WAV5asQWX9KTKCHad7urkOkztRN4Iucza/j/oUbVypFFWamwhdIq0N5CO3pbCF4Pg40AbJLbU36FlAd9KSMfjkyJZ/2ndqNiZAY7mqyP4+L2aqLMee2+LgDNyCk5lqRca7kBBsQ36i14bnCToJSxfEE9GI1k+yvTD2Hq8AIi9HpZqzPHKpPeyHeLyIVdYdO/JyLjA5kPfYn5EVgIY3+7hgFI9qkKSQGCzOOiF18Q5KOzgzFrzIcYLzwyV7SwZhY384bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47gDud7KbvmsdvrL1+IOi+cZg98jjbixyWYKeeebeak=;
 b=GwNS/+Zz/WiDUeY/HvlVEwBYxSrEkLChKhNEixf9aAcar4o8tFNqCF9zrP7hMJ+XbVALebS0uZROP72Z5h6wxgIHwwFxPjLpNsJdx0eFciI9O7ShROADMHZTRGE9NOoYkxxTwmdeLRylRrTwPXWDwU8o9cjyZ0+m+wYIqEKVqV2VliwS4GkGH3C8p29W+Gl7UjrK7fb6zvvgPWw6M5TBkI1JDU1Bp7MogwRpIdFll0rCRO7lJixBK6UZ/wDfDvbnxhb8rfX4/IobUI7s5lS7EmpsP8hMsUoUsFnJEU+sbE2vDrNpszGPYZ6TzJ09LLg2LaBs20i4x9pS3BBtcWBvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47gDud7KbvmsdvrL1+IOi+cZg98jjbixyWYKeeebeak=;
 b=kWbBOZdRPpJIxb/oXWaHsC6mgpjRcqfkFF8LdM66aO8ULd4XQRaXh2lcUKkLuAZpoFcm23A8BgPaWb2ZdhYfgPTeenQlpiRCHZNdOGP/JmvZCaZyjOM5OL1qg/72JnNnK1eA7Cy/wGmAYYljOw8Uxl2oj2uEwY7UGMM+LPmZ3lU=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH7PR10MB6555.namprd10.prod.outlook.com (2603:10b6:510:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 20:12:41 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 20:12:41 +0000
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
Subject: [PATCH v4 09/10] mm/vma: update vma_assert_locked() to use lockdep
Date: Fri, 23 Jan 2026 20:12:19 +0000
Message-ID: <538762f079cc4fa76ff8bf30a8a9525a09961451.1769198904.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH7PR10MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 8374492d-7788-429f-6e4f-08de5abbc2b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VmAJjrQWqvR7lyQhy+OD9nSJXnyAm+0uxIl0DRrDG0fXJXPPADKFCvamSTak?=
 =?us-ascii?Q?9rHRFSCghV6ngB5W/q8L7x/59KzXbBVqLLpxeSvzNdo5PN8UPGlNS7bZqeTd?=
 =?us-ascii?Q?egRZkveD4xsoRGJ5oc5W1JkL25bCp1yuOhasMllhplzhOpMp6+zKqK6fcq0s?=
 =?us-ascii?Q?upZtRdxQW5Wqu8iP430dw6bOLthrf27qzhlyVlCs9+iRO0c+DAQXU/S3IYBX?=
 =?us-ascii?Q?zmwREKGsw7XiV8K7dND1SuZN3z/kDYd1IlemU0baDR8LI523bMsv2WWiTzmN?=
 =?us-ascii?Q?7D4JlUqhZij5dfRDEpjPUZiJBCVqC33oc5WsEfHrx1FUNE0UwoJ81ayO9pvs?=
 =?us-ascii?Q?56CTgYjvWklOwRk+d0y8XUNJ+lVDxL/Na7g0biK72iwtoB0uk+m1XSPHisDx?=
 =?us-ascii?Q?6RKJHjfkzz7cw88RrV0hBiW/OHSNiUxrMzFg1CmLxvd/2J8Z8TS8R2qYIJRm?=
 =?us-ascii?Q?1uod/qg43m1fJ76Wey5YxudC68jk6pdQ05YFSXagSQ68lwNYpgkhG52shgNZ?=
 =?us-ascii?Q?isfZDfZ3h+9yOPqOzQcnioJnLg9QTmmy4irMaDRFrN+k9PnZJ637/1JoHGCb?=
 =?us-ascii?Q?WoqYZmXVXlIlzP830K68x8uShpbuTtaOyLPWcqu+u9Om5SqoVoOFskVS6HHh?=
 =?us-ascii?Q?gHKRFnc1s3/kxoOXO4lmCiYQaqYkez3WF/UVaxg0Mqc5xTOjgq11APL3Z3JI?=
 =?us-ascii?Q?Gis3fAwf9syBLqBYYmGx+g2bHvECvDbFjPEGJuHX8VgOGfvX1cfYWhwFHf2W?=
 =?us-ascii?Q?cGqV6v0Fqcwmqw+mBzzyp/1+wUKCodhS8DIU+FzhS76Pd3BOtebv5pCdmBoK?=
 =?us-ascii?Q?WOq9SOrS03lear1DU4fyD1UBjrszM6OnDFVQ2gRIKJbhYwogRZtMGfA0tHot?=
 =?us-ascii?Q?jCNOURrAJzR+vx8EiaTywNUZbXYfNVVZKemhm2aX9pHtXpBAojmtxEKJvR4f?=
 =?us-ascii?Q?yIrwfFhvm3vYbb0uBtAkbmFdr5PoEoyXoN21kWQAucWQbamdR5MYddMqd8aP?=
 =?us-ascii?Q?2pm1Ka3MVrzeTZ3TEtrXGx7XVLqKsDBKyigViILFSzysNCpY6tNzrxqZUm+X?=
 =?us-ascii?Q?vssRKV2Rw8kWoUxgAGaNSU7DZk1nfxNqGeC3LfGMc/Jxy1xoj17Zh7wa2bQ+?=
 =?us-ascii?Q?VRLxRTpatsFgYs1kX3NK7ewrafKxX0F4zrWzAAPmW+nKUbPZw+T12/7BsI8U?=
 =?us-ascii?Q?4lZyr3GTEbN3v8FxuaqUEnZnv6Lk6DJWdH45u1+NubvbhVPnW4+qx0tDEcsk?=
 =?us-ascii?Q?2o+azKcHSB7I1OymZHECuhPzjG/sqmgFP9oHh1XwUUAtx8fEwJBITpabgXch?=
 =?us-ascii?Q?dkgBpUze/PeOnAektsk9UYbRvSo9yFJ/d7qu4vQaAfg5G8LhR+ylW5h0/3t6?=
 =?us-ascii?Q?Fm2ERt/M6Iok1sFtwnybbrI/yfQEq133DghNvuTc/GhQLaO6qGO03f1pZZwo?=
 =?us-ascii?Q?UIoUzxJh5G2B0sqQIkRAU8hV0UIylQLHHqz7Od1sSedikxaTJIeHtCF1r5aB?=
 =?us-ascii?Q?KY/qFayIGG4AuZj5E+Ijb/BlCnTMBuoOfcgpVQjNPsxwz4pkNePqPKYX023U?=
 =?us-ascii?Q?1FQ3x5iDwi45SGrqRUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GEOgVbFS/fLsxOwImrDFHLQQ6iwB6bjF4x18MI6dSYD81/RavmeG8hihp3u0?=
 =?us-ascii?Q?wk4Ua9SAfVyqDKlweRE0FEOq6MHaFliiBC8nfJyzRgv3j0QytSVHDkl4yvdM?=
 =?us-ascii?Q?pzVGGhCMCX3Ety8uhz39oSV3NlW4fY3jNnjgOEUN/p0KxKgFXqVy6xhGEyO6?=
 =?us-ascii?Q?JMpnoxTsUqpyHq9oEXAjdM+FSXQk/x/Knpu870Z4k98d7njx2/sXbn+EgnGY?=
 =?us-ascii?Q?UOy1DwKoowciVf+XriuJL6NhIbKMtJ/FIyIWAfu7YCFlRpqWOaD4iiaNV1QJ?=
 =?us-ascii?Q?+2Y8ec2oNqk3jj/gcSq7FaTse52FfX3q+FjpLjFYXX2QQyzSpLlh4zkxnGpR?=
 =?us-ascii?Q?LS87+pIkocB0e9peDGD7GuAMzNEN+5Pr1QPpJizzG9/WKGTLqFlIM9jB+IS8?=
 =?us-ascii?Q?X58kBwSxYo2E7E2X30U+5myW4Cmd/BvRvCPm0m1oPyV0mEzSMtzLbayvgjPY?=
 =?us-ascii?Q?Ceg6OIn/n9eSGM2pXwUzlDQemYYZNISgrvQGcUsOkuF8LhmSaHiU9KTZRmRY?=
 =?us-ascii?Q?jqGvz5ShrqejqTfJE2ncE2FSsIbhUYmVM9pTKt2D8yfVcFMPIP6tqsf81PM/?=
 =?us-ascii?Q?Vtc+IP2FdOByRHubsLTJTxraQ58t6mOsAN67cXVYnw+uceIEx6NUNo4fh1zA?=
 =?us-ascii?Q?uEboPaTC46+RlTL2JmSBQMLqLqYvfaubci6qu6JX3r1t0pW+B148Z4E0xF6K?=
 =?us-ascii?Q?HhO4fuCOcamKJ1Ar7k3Ggfm2piLZmzr0sJRvZj8O2hKjtN6rUXUwtGIyasNH?=
 =?us-ascii?Q?Gv4LzbGOk06CV/9zoFDeweF4Mo41SfaJoId4RpCPUvfL3CkjuUuVCco/Klrr?=
 =?us-ascii?Q?jKskKVHM1/PYlXng2cECBw1ZJQTnd8hyfzcgjbDpek0x5tzBzEjemUVJlJpY?=
 =?us-ascii?Q?G4e2H5XEiYuZcEsFiA3+C8y1y2Vb+JTPSzu6X67lPonn+nbryveWAHovT+6b?=
 =?us-ascii?Q?CfVPHLHo4UGSo6eZ5vXg8W1JjAhWjna5FpFMjMsmNyX9K5EP0G85WcEBzZ6u?=
 =?us-ascii?Q?5UimDQvRN6Dy6krWSHlKpLVTjQeAa+26BrtPcxBONGhghZHG2R8Ira+UDtdR?=
 =?us-ascii?Q?DZiIXdSViZJ2YZ8tFb6DhLyUtL+I+N0pPzJh6XIp0/YFWKfxYItatvCUlsyC?=
 =?us-ascii?Q?e9aM6Swzu3frDql72nzkuz+MtdFJRZSBlZ7KDUqFkX2etyQVDPxmXoaA27xI?=
 =?us-ascii?Q?BHn9S/Wn+eKdqlgKYv2YELOduX8HUrkelT0HUIFBZ+IWNwjAW2S2pI4LMkaF?=
 =?us-ascii?Q?KEKukaDbzcUV/CAnyOm84Qg4VggVCKYUwZrdM17M3uJ0T/AINqGzC5nsSIAc?=
 =?us-ascii?Q?5RhgU+VjST4fMtDWWFpSyXP67paCM4jyUtb5VO7Q/Ntxva/4VF7rYRZ9Fccl?=
 =?us-ascii?Q?A+CVxXABjZjWrmVPmmtN72ZhZoZI3AFDNY/uzMq46PUuyBPQnCse73p/49kV?=
 =?us-ascii?Q?f7zvumDJC7Z6uATiSa1/Q5DFOzAwZULFKXve+eKzJsn/b2VU8mqdIeKwfZC7?=
 =?us-ascii?Q?Jla53+Wyu2DTgZrIgWotw0NWtYaFvedPZMNITZFODdY0FYAMlSzwG9zc9Gsr?=
 =?us-ascii?Q?79Qzmcjyt5N4/k+ise0gaI/u5evGLNbUYPZ2bC0AHXV2ueWuuIZVIL0iCBcg?=
 =?us-ascii?Q?uDPnRFj9mdsIAbKhpP4kKZK4sP/k/C+KWX1jzZzeg86qJYlZD6krEHPfwUon?=
 =?us-ascii?Q?+zl0WD9ULJ7cCs35B8mvkCdnKRKdnMMA6URaT7ZQ3yxVJGOAHH5aYo3S0U7a?=
 =?us-ascii?Q?hIUnT3AT/8CajJWoaucjze39wIvPG9E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GffRX5BNZ9yAHTpyawPhu0SZJOFEwv+c77IXUsgoerGiXRnq3yzT8gLuduPBymGzaXLI/mRs+F2X/pNaWrkrAXoKOfiboGP7I3KhhORVxrSLI2lnnIwRhjKbKbwE1db0IR/k0uO4a+sxzj5LT86RMMx/vJDWi1vNzjFR9sOqeDO8hANLtgTkEghqpzBC1fQ8sgjdNEkhbQ0LgbC+ebakVhF20u+KzYK2w7mmhMMZyhu9OcNAcBBpXaaevbhuaAXN6C7emud8CyFVfBnSki55y1mCBXZqC8444M4DTCzUVjsHhGY5PheLRaO2BsEgeEkiSHGP/WFquy7lk7LXdMa6iwfnGQNwirGQlRPnv/f6UieVGFxbYMwioZBWomGH6BddUXNM18pMfPezHxY2YErKop2mFuza/dEbaJJNOnTI0DVPsBmxjZve8nvKnHP41Ps+fYPCVucbm0PAy05RQWkIYni9GU0G/Gj9RsFiAOQd/kTEErtOxLyaBJ+8uO3TdANf+DNYmtDhK7USxfTLCasklp5xY6uKrN8aKSK1Jc/8IdzgI0nU3KNEDuUS9/luv9nIfpw8eRt5Ai86Y2xW4qcc//Vc6ufeVv5bAIHPKFJaRQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8374492d-7788-429f-6e4f-08de5abbc2b5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 20:12:40.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 269gVi6p06WFC7jQoEEKcBxZUWcQnI88iSHjhxazQN1F2DVlgaFj8uBFUqbz1NyL3CkoFLAqSa/nkI9UmDLBHtf7fBfTuw/uivw2rR1TS+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230154
X-Proofpoint-ORIG-GUID: dEtBI5x8G-CtQArbqA9pUSPMt-KElKo8
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=6973d63d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=t-UrVdh-U0oxC4GB6fEA:9 cc=ntf awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE1NSBTYWx0ZWRfX5Eewi1HV7BL8
 ZlwTIB9bYlKncutMGr48BKrKKl8/uqrRaTYaLgSwQPcDlH4+1LF8XS5eFfBWHWDngHs/S9w7qOi
 5TDg2FWE9qJXyJ2eiM5wb1NVrqgYvCFu/4eYCAWy4+wvGdgBugIy5mWzpHWBtm42A1lnLFk+Q70
 IlBpLDbjrUUpfRR0BLMXy/5or1/hLfjsAdB8GXd0h1LXjZgoc9NxzwP7HslxqsewPlyMFNaI2LP
 TrdlrqAWiloGRr30g4mWO/2v18z1BPS9qFVez7+jNAITgLXsctDrQM6gHshNV0TRONvj0w0CHUL
 pn7Rp3byOybeANMe0Bt/lXix9/yps9lty8t1nL1eO+e1r/It8Xprl3Fl0KlEejwLFZauDXMgHyR
 hEke988s7B4G0UBokQO4d3m5HQdezgH3zHjO+TcAqTnD3yX2ZPV/26AGF7oYEVZJbEdvZVC+v5e
 XvXSdy0rIciMJq2dQ4hTbYnswIKJ9DgvPpbHiBO8=
X-Proofpoint-GUID: dEtBI5x8G-CtQArbqA9pUSPMt-KElKo8

We can use lockdep to avoid unnecessary work here, otherwise update the
code to logically evaluate all pertinent cases and share code with
vma_assert_write_locked().

Make it clear here that we treat the VMA being detached at this point as a
bug, this was only implicit before.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mmap_lock.h | 41 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 23bde4bd5a85..4a0aafc66c5d 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -322,19 +322,56 @@ int vma_start_write_killable(struct vm_area_struct *vma)
 	return __vma_start_write(vma, __vma_raw_mm_seqnum(vma), TASK_KILLABLE);
 }
 
+/**
+ * vma_assert_write_locked() - assert that @vma holds a VMA write lock.
+ * @vma: The VMA to assert.
+ */
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
 	VM_WARN_ON_ONCE_VMA(!__is_vma_write_locked(vma), vma);
 }
 
+/**
+ * vma_assert_locked() - assert that @vma holds either a VMA read or a VMA write
+ * lock and is not detached.
+ * @vma: The VMA to assert.
+ */
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
+	unsigned int refcnt;
+
+	/*
+	 * If read-locked or currently excluding readers, then the VMA is
+	 * locked.
+	 */
+#ifdef CONFIG_LOCKDEP
+	if (lock_is_held(&vma->vmlock_dep_map))
+		return;
+#endif
+
 	/*
 	 * See the comment describing the vm_area_struct->vm_refcnt field for
 	 * details of possible refcnt values.
 	 */
-	VM_WARN_ON_ONCE_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
-			    !__is_vma_write_locked(vma), vma);
+	refcnt = refcount_read(&vma->vm_refcnt);
+
+	/*
+	 * In this case we're either read-locked, write-locked with temporary
+	 * readers, or in the midst of excluding readers, all of which means
+	 * we're locked.
+	 */
+	if (refcnt > 1)
+		return;
+
+	/* It is a bug for the VMA to be detached here. */
+	VM_WARN_ON_ONCE_VMA(!refcnt, vma);
+
+	/*
+	 * OK, the VMA has a reference count of 1 which means it is either
+	 * unlocked and attached or write-locked, so assert that it is
+	 * write-locked.
+	 */
+	vma_assert_write_locked(vma);
 }
 
 static inline bool vma_is_attached(struct vm_area_struct *vma)
-- 
2.52.0


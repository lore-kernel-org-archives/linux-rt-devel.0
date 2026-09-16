Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9FF4734EF
	for <linux-rt-devel@lists.linux.dev>; Wed, 16 Sep 2026 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545717; cv=fail; b=bNPsOZKigzwyl6PwAa8NBRt4s9QvjjCDGxa+vRyedjg0ycjhjb5ZVpclpgwIYdWW9gxLQ1p0oGcv30UhNeWA0KbwL+zMe45v9R/QHkDStZwPjCsrpTklgAqjjCr8v/76M6bJPIPWNziugP6FAH7VJZcuFyqoXDOUNrGkHk0XviA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545717; c=relaxed/simple;
	bh=1bz+RTXItRVIwNysVbPPclGKNzoUaJsnWoTKCFkCT/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bBOT1BNLLD38fgrQ38ufTI+JElnutrbeIDyRUyILFnjzggwVOnxfaPFJ9S373p17klpPFClIEwt1R3JIp8JhsOiVlnG0LDGVb/p7irWbk62R3yBeRUomF662QmLlt3o/ofJZUjja2pzGNwk06vnlsi6KHcTjSOWRlZEz32MemUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Vn8d/97; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Vn8d/97"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA+jh6QCHf+K4qc+krblx01Yr6t/k0TvumFYqAhZ8RJcsjpXbJ8s9dIcBDZWjZMtefT5h99BPXECtE2tuCBQXTrUAIyWNUfI3ERzIUDy30g5q+SUxSr2bCqCxs5s0GKnMh9URpy6y6iIpQeFNtFOOIwXDHlwl/+3UPZlOq7aY3IoknPAqWtq1V8JVt3uG0pgKFjiQm415Miz+mU32O32Gpb1Pps9J2t6yNr08FPghn6i4076IQAcrpLBu5wz8nd14qDeQYaLsrCrrovX901zlXMUvg3APXiRL1dQmp/CKhpHdFOXilve3RZoyFsY4X7mi7Z+WASMc6kcAqyTosCeSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDM88kOtl2CKjxeWB03RZeGQ+B90JmuMn6GcClQMRFs=;
 b=ureHEaJIVJbn8VGkHmD/NxVHCxJLQCfRxCe/EFEzqKc7r+BJYAna7hTPkbf5GXEue9jyBFZr0iZ6D7EVr3cdflx6C8Fuf7uVTk9TkC/UXDPKgUB++uF2m+YDW59MHxd40scHtgqrhSHTFLWb+QtRnzkdUcpwaem2EcTKdECRwZmO0VQKMlQnr2aHvzo2sSHK1M/2Xl52AQ/lO42D22YVdpaWqCXQ4une6LGevUFdX1wpgCrIDS5B+RMxNzdTYHenMdJb7K+4D8a2RdTdiyqXrv1MXhkGBYBtpMKUa/vnC57ojA8DJp7gAVHKWWoQLl0oYOX/sdKb2MxJLdyFCFWGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDM88kOtl2CKjxeWB03RZeGQ+B90JmuMn6GcClQMRFs=;
 b=3Vn8d/970OJfJaDSEBwhQdhli8Mn2bnySF4lfTC2/d6/8l51vkDCKqQy3QOiMIb9IkCV3zHJwMbQTghwaR4FU7uWwFNkwogQPVl2g5MV+JGjGyhUBPzOtcSgmeASm3wW2P1ZRgwK/fn/7hUy16jXtIkDvPrAm/SxKirofeu3nSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 08:01:36 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 08:01:36 +0000
Message-ID: <cab3aede-940d-4ebb-80ac-41f4755d6d78@amd.com>
Date: Wed, 16 Sep 2026 13:31:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] Add Xilinx TSN Endpoint Ethernet MAC
 driver
To: Jakub Kicinski <kuba@kernel.org>, Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
References: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
 <20260915172232.04df37b2@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <20260915172232.04df37b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::7) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eed17a1-9295-408c-78bb-08df13c8bb13
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	YDW0deLW1vJIl0Q7DRdpvp7PigHoTbIhUbqwn6uWIWCOCvQzh8XkFHCswG1HuaAp+X14lqd2FBsye0mXsuzLkKE+rAe3uJgcCq+Q/tTqz7GSn5VfONI7e/gPqPL15zNha65aVyHHvZz4pA2cyEL9xtIXomJBTeVj9gvFgU74jFxDgSViK0aWG5kDQzfir6J9a7LfeYGZSMF8ROaEQZwXn01rqIcvXdJesCw5eIeA68csPciuswHmT1AboMGKISLA3jE2Cp+CJ9E9Vg9y5kkxCTbtL8sfwfIsZR2ybyi6x5qoDK2FGodcuVUJigVAQWcQZYqu3Z6JHED4RehYAlTX7Yi+3F01FMJYRE3IlmoH9IuHbMmSbWrG/c7DIDh2R1Gq6UIU2GWxQpZlsJ4TvaWMBGQah/A77QSC9rzOie9Nr+B+WDVl1Msz3yXkmJ5dBXpdTEv9UjsU3ueD02xRi5Qlrhh8fH5tAWZFmQ3rJpgEsVuti9lcjen/+l7OIRQacyoCBIqbsxTLUMfc2aw6yHypA8inc+roUyLaglNrS+Uu0Ubce1LkXyzptWh1dGdmLSJCYK5yn+s76kYT1lyc5fhErSgKxx9mviw/icS9qppTX8atyMT0Q1h0QxfLrZXWXbYkDiQLtmdqDseOr5f8tEnQpiN4y2p4jsxzargTHRi+Cmk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGZjazBWTVZzQVkvS0J5aTlBYmJqMnBPSnVQMG9YdTh1ZEtCT1JvNXZFb1RR?=
 =?utf-8?B?Qnk0UjZld0hVcUhjTUtMVFRrWWlHZFA4SnMvOU04OXArcTh5ZEx3THdkOTdK?=
 =?utf-8?B?d0Vrc0xpOGZFNDgvdzBDVjlFL1hybmwvOGc0OHlKYkFHN3BQdVc0eE9lK1dx?=
 =?utf-8?B?bERxYnZ1Wjd5TE5CdEQ0eWtBUVF0LzlndVB6ZzkzdWdHMlVOQzNRelNaVXFJ?=
 =?utf-8?B?dmdPc0gwc0pramlMV2xjQ2lnTEh0eXFRQU9SNzk3OG9aZU9TTnFjRHFEQ010?=
 =?utf-8?B?VkkzS0tnYmJqYWNhOWhDUGRaMkNxWkFqZWVYa3lCWGtDVFJrUlMxRUNZZUt4?=
 =?utf-8?B?UGFMSllIRGhwUVdGN3JlL05KMkV4dlVPUStJelhnNnc5R2l2OFRpdG02THRy?=
 =?utf-8?B?WXM1dGQrUmlIZXZ0cnYxOGdKNUZHOVlsVDZzekswZXgrbzBWem5USUJLQVJv?=
 =?utf-8?B?K0V6ZE8xMzNBWEdzb08xOTdiN2V6c0pwUmNQTEdKRGNvbzJ1V01tMk5NT0hu?=
 =?utf-8?B?TnV1b0c4S3NDUW9KRFlNZ05OR0QyZWFSWVZyVVVqTEFZMzZHSFBTU1VveWxB?=
 =?utf-8?B?QTBVY0F3cDY4eEJxbDNMdVBlY3ArQ3lsVnU0cTREN0VWbGkyK3BaUU5tdUMv?=
 =?utf-8?B?YUxTMk9LVWZkMEh6MWtXQTZYTEQxWjJhbEZlOUUzaHZEQUp5VVhnUld4NWxj?=
 =?utf-8?B?QWxSRWtOK2VYRjU5UVU4OEtlN0ZWV1pCdERab2t2MitmcEorU2VwSklueEpJ?=
 =?utf-8?B?SnBoOCtwTlAwWkxOZmxVeTQ2anJPZkxpK3A0YmoydXdiQ295RW1kcXdFOFd0?=
 =?utf-8?B?b00xSkljMzB1QlU0WW1PaXFEaWIyWHI0Q1JXMmx6d00ybStuZUpPYlVhSU9O?=
 =?utf-8?B?cSszdUJoVWE1SkpKZGwya20vSTI1cEpmOXEyeGNHeCtkTVp6ckxkeWVlTDMx?=
 =?utf-8?B?MjdzaHo3bHgvU09ibWtjbUxhSWJoREE3MnFrdmZHZnN5TkFaQm5lTUZxS0l6?=
 =?utf-8?B?dml2YXAvdSsvM01oaEU0aHdIUVVaTWRITnF2UHVCU0dZRHpKSlJyYmtYdHBh?=
 =?utf-8?B?MmhrVVhzRkFDbkx0Q3FpUkpEalJjQlVqcU9nZ0tEMUhLVXVoN1lBKzgxQVBO?=
 =?utf-8?B?SUZoVWN5cER6TW5WbHYzdGVIRGd3Q1JzNEhsbmt2ZWtMN2tZUVVMWXN4N09q?=
 =?utf-8?B?cmE3enIvakV3SHBvSXVqWS9zTk9WZnZvbGowNDYweER5dFZ1SXFheFM0UU5F?=
 =?utf-8?B?VXh0MTRUOGpQbEIxYjBNSklleUFsRkxadER5a0dVRFlSdG9GSHBPd2ZIajJ4?=
 =?utf-8?B?UGFIU1B1UGwrRWVPTWJGakNNRGJMemJ1Q1hmVXdvcTA1ZnpEVlI5TmxON0x3?=
 =?utf-8?B?SWlvS3RkaGFMUWxtVEtOOTU4TnNCbDVZRnMya3JvTWFLNE5ROWNSSlFzVWE2?=
 =?utf-8?B?bHQwcXVZeFNUYW9NZ3c3UW5EWVpPOUFqSDd5TUJCZi9mb1ZhdzhPRkZSWWRi?=
 =?utf-8?B?THd2OUhHM2h6Q01kVkJrNXh5bXFaY1o2RVJESnEwclFlcVhUY05sK050bW16?=
 =?utf-8?B?blBBaE9GVjJHN0tqY2F0Zi9GSXJKOHFoMy9QNERHY3ZsWkEvQjRiL2ZFaTVS?=
 =?utf-8?B?Kzd0OXVjK2cxblRYV000eDkxT3hVSCsyTHR0N3RUWGh4aCtOcWRPZDJWUTFm?=
 =?utf-8?B?R1YzZHFwSitKaW5leU4xcURVM3VKZkF5bTJZVHYzcitkbzUrdTNnbGIveE84?=
 =?utf-8?B?Q1E0bGlVQTZBU1VTeGc5MEJTcWwwTFFkOUFpck5TdGw3MGYwRXk2Z1hkR09r?=
 =?utf-8?B?Q1gxSjFDSlg0cTd1RDRjdnVnZFg3NFZVYzhhWnFwQ2RFNDQyOEtyQ3NoejNK?=
 =?utf-8?B?YWs3T09yN1lBQVZTbnRZRFdTRG8xMWRjSnBvN3dqdEs2SEdMM0JqL1lOTzM4?=
 =?utf-8?B?SUZUT0FmSlAzMDMvNGRrU0ZRalEyWWdMd2hpbVZ4Ulc5YldmeEU4Z0gxazMy?=
 =?utf-8?B?YW5aQ2k1STVISEJMOTJuUk9VYXNPaWxHeTkxYjhmQ25pd0NZcjJ2T2JmelIv?=
 =?utf-8?B?YzUweHoxWXJoaWFaVDFRUzJXSkpIb3BoeTJuWG5YMW56aWJ5YmI2b3N3bDFF?=
 =?utf-8?B?WWtKbHNWUWRrdFJRVU5vZkVuN3VkMWFhZ1pQQ1RYNEp3bENjbVM4d3phVnps?=
 =?utf-8?B?T3dTWHVTNGtyZHJTSitESEI2NU9kODRNc1lCWk5XZUFYQVE3MnRpYWxZSUNl?=
 =?utf-8?B?TjhoeXZOVzRmcGsweWt1TmJ1WlUrbVMwelFFWlN6T1Q0QytyeXg4eXVPQUNo?=
 =?utf-8?Q?peIB/73zhK6AydWJFg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eed17a1-9295-408c-78bb-08df13c8bb13
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:01:36.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ob/sNni5ql0ceeG8oGhBUsi/HUg6xQhg7pz4939c0Ss4E8a5HkPW/jzj1pyTPM4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167

Hi Jakub,

On 9/16/2026 5:52 AM, Jakub Kicinski wrote:
> On Wed, 9 Sep 2026 00:49:48 +0530 Srinivas Neeli wrote:
>> This series adds the wrapper and endpoint side of the IP. The switch-facing
>> part is exposed through the Distributed Switch Architecture (DSA) framework
>> in a follow-up series, so that MAC1 and MAC2 show up to Linux as switch
>> ports with the endpoint acting as the CPU/conduit port. The endpoint frames
>> are already classified by source-port id and tagged with DSA port metadata
>> here, so the switch series can consume them without further endpoint
>> change.
> I'm not sure why you're implementing this as DSA.
> This needs to be explained, if a single driver can bind and control
> the whole thing, that's AFAIU preferable. You can keep the
> implementation details in the driver without exposing the conduit
> to user space
When we sent the 
RFC(https://lore.kernel.org/lkml/5f884e29-151a-4ee7-9e1a-d7e1f84d9f6c@lunn.ch/), 
Andrew framed the choice as: if the host sees a netdev connected to a 
port of the switch, it is most likely a DSA switch. That matches our 
hardware,
the host sees the Endpoint as a netdev on a switch port, with the two 
external MACs as user ports, so we implemented it as DSA.

The Endpoint is not only the switch conduit. It is also a scheduling 
endpoint in its own. It drives a dedicated hardware block for 
time-triggered per-stream
scheduling (IEEE 802.1Qcc-2018, Annex U.1.3, "Using per-stream 
scheduling"). That block is armed by a schedule programmed on the 
Endpoint's own Qbv scheduler, which acts
as its time trigger. Configuring that schedule and the per-stream 
trigger requires an Endpoint netdev, so we keep it to expose the 
Endpoint's Qbv/taprio configuration,
distinct from the wire-port schedules on the user netdevs.

On the data path, DSA maps onto the hardware cleanly. On RX, the EP DMA 
path delivers the source port in sideband metadata, which feeds DSA's 
existing metadata-based
demultiplexing to the per-port netdevs. On TX, the normal data path has 
no destination-port selector and the switch has no independent per-port 
forwarding mask, so
standalone isolation is done with a private VLAN containing only the 
selected port and the EP. The next version uses DSA's tag_8021q helpers 
to manage those VLANs, insert
the destination port's VLAN tag (which the hardware strips before wire 
egress), and handle the transitions between standalone and bridged 
operation.

A single driver could control the whole block, but it would still have 
to reimplement the same pieces, RX demultiplexing, TX tagging, the VLAN 
lifecycle, and the per-port
netdevs. We chose DSA to reuse that existing infrastructure while 
keeping the Endpoint and wire-port scheduling controls separate.


Thanks,
Srinivas Neeli


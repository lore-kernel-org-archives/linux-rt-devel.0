Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB564078C0
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244375; cv=fail; b=MhEmg2i/lZkF/yXLZAF3uqt8A1CtjqZQ+TR3MihV8bIzrwPFJc+jHMq2/iP/JMCnHA4x2Erq1cyPQcygXKJDXVU6vxAz3Oj/JDD/rlfIlKXo1fu8rubGozlTiTTF5OATrG08cJd2skBq7DrT9FkqHZBWlLpHYvhVoiZJj5O+Xss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244375; c=relaxed/simple;
	bh=FO/H9OWv+RbV9K9R6x5RqZJ5osn8Q0kcd66M05iiXjk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WOnlGjTeJfjDe9Vh/ZTc7Ghwmc/U/XVl+ZJpqGs009hKRpkYkbRp8pQMuBSHrhxtfhMhCBQvoGfwedbyulRt58hnEXKJ86DHtmfnYN2zCMXGVmz20eXx5q7PjyqrJgX6mfgNpXmBHC8iVhBnJzrU2xawCHRHF2xkWhhndQkuLNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0wyK87bQ; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0wyK87bQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osVqeIoJT94hlVvzudcxN5Z2tSMb5d3Wajs4lplEAN6TG29HMfl+OxjJIzXkT6JSvTqIjH6MejcOBCGRvfEEaJTrMNlQ7BFGL7sTqnxs8AZD9CodQAxT0QfV6YBsbYlPkQPmRKxtytVHcnwPrEKvi6g7l8wWkzddcNES7WOC3h41prW+11BmcMEWBQeEiyHx525zhzxwYLcQIYg0dXbU4Ri9wubePXZv0MbazgBsKAJ/8TrKz91N72Dx9+Y8MOcZu3bBIQNOFg25HfOB6tg8K2zy7JWFoiSAwWYk1qMZSAtE8i6KUB3WNdme1ZDIWy/qX/8ECkcBwmBFqGvY7GU+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhyGBAL2E6EVZeenmwAj9M735izEtUgCVlFmoGEthqc=;
 b=XZdqxpbm7FvQm+iCndQB3K1RCjHGnjVdziuaJRREVcCmz3wDe1vapFJ7J7/TCch4U9sgLjctyWrRQ0X/ix5iD8b4yU4x7Jw8Dp0LxNn5XQPxVoEv0q5O6wRAnTzlYK+hboyI4NO7X1f5dpULFQnUl22WDkneCe6ehGxvmAIgWsVuI9p9JzrTEDkXXKzxWydzYG21KV0YPHijOzfbOlDZj9vwqSwsOgSKebOcdwuYdLv97j5cYlfpXj4SEx3Dztc1had+e+w74dYCJJolA35S5CdGbZzIsgXXhc4KcJ9XCowMTlqoeRDJ/Cuqkz5kpFmrGddjvu+fXL1y41Zp/qbaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhyGBAL2E6EVZeenmwAj9M735izEtUgCVlFmoGEthqc=;
 b=0wyK87bQ+OauqMkk7JM55AprfrQ2MDk3DGMD0OjWdojVvNLrjfn012hCfEzVCq8FmUqVcdEJ/xSUw3+bxvhTlFcSitC87c46KaUyuPj4/pnfX5iBrKXT0BYtqNO3+Ykg9FX5FO8EgXWU4RHMyeuJDkRIkfuDiEMvXb4YGldeSv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:05:54 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:05:54 +0000
Message-ID: <c5bed931-47fd-4538-8600-c40b8ba745c9@amd.com>
Date: Thu, 24 Sep 2026 15:35:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/8] net: xilinx: tsn: parse endpoint DMA
 channel configuration
To: netdev-bot+sashiko@kernel.org, srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
 michal.simek@amd.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
References: <20260909-patches_v2_external-v2-4-3a40babaff4c@amd.com>
 <178924537042.3125.10976584091391894658@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <178924537042.3125.10976584091391894658@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0115.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::10) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|DS4PR12MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eea1324-2aab-48e6-f4ab-08df1a236bc0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	yn2iI3GgI823PgzwrlEMCWpofwo1ZOfCenuRobhCeLFmpLJAGIzBn82vBZvhxaBqs2w5mMTk4V9eKkwQvDlHaf//dmeHTKtjr9ebb/yU5uUq1XRnPZFu7anJUfnN8Od0+nJyijS3GTbmuCKvJxTgjS2NxHdf6HAvuRE8D6Nb5lZCViuD6sXBt9MZd4Tuv8fEkBxUhxyeH2dkAdzr8W8RWZvwG8dXUawTv8SjTJSXh8RXhHlD3hv1IYeFd4JTinOZeJ/7aknkQCfZjp0eAuRga3qnsYEjkGrM51gSwtGw+BToXzZBxROUeso3ySvX+vdoAheT4pdjv2OfnrmO0/I8hII03Hqnidsji+F8dzcI/X9wgWH5iYi+0vML9JZTW/t8regxPPgFSjaxFiIx4L+l/7eTMJc+9bB3t6xtH95CN+nc34mnsWp2xlY6PSoiAmiR6JoR5BWCgUrAq9pwVhWqClWxN9op63mbnSCryl7mXKSX8K9n1xMlbMcgfmzEyOs2XktpR/TDoPwYcDbFWS8U+Gduy/PXvTrqfQH4rVGPC4tOBAM6aIRfaxF2PgTAo1z8WxdQqa4Qa/m5splhVAOu8i69Jcnsz9iJ+ITwta2hav9oh45w3dwJ7CP1rnQB4UgUrlENsQ8Xe/3wacN6iVSTTTebeReBsUXSz454YrW+9oE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHZTM3pWUThOOHZaYzBaMDlYQnhhZ3RvSHBnY1JOam50bldKNDBGUFovNnhU?=
 =?utf-8?B?R3I0Yk1aTW44L1M4K3N4cndjc3NjRWNKZ1ZHSXBucGNzcjhKL0FRSTc5OURl?=
 =?utf-8?B?ZnY5ZnIrQ0d2NFVwOGxDUjlxcjgvYTBaVm9vUS9EMXdBNmdBVDFycXRnYlB0?=
 =?utf-8?B?SDFQWUVZd1RNKzd2OVpsbXZYbVhwMnFmVmk5VWtJeDdUSDkvOUpCemZvd28z?=
 =?utf-8?B?VGZiM09iSlBxRGFqN29NMFdDbUQ5b3lKL2luQ0I2MU1FSFlCVzNkQ1pPQjhI?=
 =?utf-8?B?blMzSkFBVEZJTi9Nc2tpYXZjWGNJTjNCUGtKVDNZcW9TQTFXL1JvQzkxZUZL?=
 =?utf-8?B?RGJoRkdKQWFYMTh2MHV0ZEZuWktDejBFS1RKeHBITHpURHd6TTFTVHV5L3Q2?=
 =?utf-8?B?MDV0WHp6ZTd5VjhIS3JQUnNiRW5FMDlwY3U3UWROUVZLWEZ0YVd2NnU4aUJS?=
 =?utf-8?B?dnZHbTZKU3VuZ0txVU4zR2JhYXVERFBRalBhYms0UGRZVW5MRDVIRFpFK2g0?=
 =?utf-8?B?NXZObjVKSXVPaGJYZlBLcklQaVVWaXVwUlRmbVZZUmpiYVc3eVM5QmdvREFQ?=
 =?utf-8?B?akZyejRoallFajd1ZTRqWGlKNk5vUjNEdjl0OWMrNmhzRE93QUFDWDRFUjV0?=
 =?utf-8?B?dmF0NlEzY0FwYks0SXU3dS9xNTVzZTB0MjhKWnU2Z0xIQjI3Y1Rpak1XWFVv?=
 =?utf-8?B?dXJsMVFSbjRoNkxaUlloNjdpZ0UvWXk1aTNaSHh0aXNJQk0yYjlnanVFRWdt?=
 =?utf-8?B?ZkJ0YTFCd201WGpTWVJVM2hHdTJlN0Q0OWZ0VmdyU1R3WjlCY2xnLzFxN0Ru?=
 =?utf-8?B?YjRQYlB0b0l5a0hwUXcyVGZuWmdQd1ZxRnNuV0xQQ3NZUGRrMlZWODgrMWtm?=
 =?utf-8?B?V2hua2ZPaEJSOXliZEd0YnhYb1F6c2xNRldoV2thaWlDbXRFWEcwUDZNT05J?=
 =?utf-8?B?V3pJYk1HZlFGN2Q1Zkc4VmlacUtqemZiajAydzRrQlJMS1F3L2w2Ty8vNEVJ?=
 =?utf-8?B?alRrNVZUTEVGTVh4ZitDTVM4Y240TS83WS93KytaNDF2NkdYdmxJWEZ6bHFI?=
 =?utf-8?B?b1dBaTljaHYvajI1SUZpL2Q5UmMxbE1oMWtwbVR0cUZJVm1CRGVqeHVEd2M1?=
 =?utf-8?B?bXZLYzUyWm51ZkRKSzdzQTBhRUQ2OFNFdEhzb3N2L2tDeGFaRjlLNzU0aUhT?=
 =?utf-8?B?OGF0ekdoMXZ5Tm5nRXZWQ0hIUEFSZUJZRVVmMUNaSHVUSE1UODFlQ0hKMk0r?=
 =?utf-8?B?dTkyeU43MnV5MTJaOGZ0UDg1RFNldVptVVBYeHROY1I0TFNPZGpsbzBxbmc5?=
 =?utf-8?B?dnd2SENna1NWTnNIbUZ0Y0t5N0dZdnJ3VE1maWVvL3BrSm9iTmVKVkRzNm1u?=
 =?utf-8?B?RVF6S0FqMnZSVlBJRkk0d3R6NVNIdVdJOHJZK096cnJOQWdta0t0bS9yTWtC?=
 =?utf-8?B?NkVMNDNiaExxVlZhYi83bVVzRHVRdlB6VmIzbkFtdmgzeXd1dGptY2lJRHJD?=
 =?utf-8?B?WlZwRUNNR2ltd2JabE41enJCUzBpWDJoblVuSm1nbEl0c3ZQYjFMeHRqVnlj?=
 =?utf-8?B?QzBEa0VlZkZLTjJCdm1sWnVBeS9VM3pGTUx3RDhFMW1JMm4xY2NPWFBJbkJB?=
 =?utf-8?B?OStkcitVTWtzMHZIK25lNmEzK1Nja3lYUjlZWWdONmNxYkNjaStMc2l4eGMx?=
 =?utf-8?B?SU5samZiY0VVbjVPaGRqdlRSSUlReHcvVDBkTFUyUHFXS0ZxVVhtUVJmMVdF?=
 =?utf-8?B?NDRkanZCS09rUXh5MVdRcCt3dXMrb2w3QUF3dnBtb3NFR0NZUFdjbDZaYmI4?=
 =?utf-8?B?dVlNU1VVdTEwUGZsL21FYjBVZVluL2V3OVVDdElScmhXOVpQMnh0eWtGYXdW?=
 =?utf-8?B?N1RVUU1IbndYSmwzQThDUXlpNXBFdWdKS3RWUytFaWJDL1FXQ09BSjl0a2dD?=
 =?utf-8?B?QVNLVU9LL3NJNWZicjYvSDRPZzVBV0cza1NzNVVQTFFPR2htWUF3OTdLUHJP?=
 =?utf-8?B?K3NWZWx3ZmxjRXN0Ri83RVg2WFpDL1NoNFZoZEUwSDEyemVUQTJORW9zMzE1?=
 =?utf-8?B?L1duNUpPUmZ3R0k3UEJFYmFvZC9RN3VyTmdJbXoxZnpkeW10MVNlRUNjNzl3?=
 =?utf-8?B?WmNCdmNQeU5pZXF3Q2V5Z2FTVUNEVU1Vc3FoQUpQc0NsWEZveGNFMEllMUZ3?=
 =?utf-8?B?SHdqdk0xbWUxL1RWcUdEZHd6aFZ4M0dhNkRNSjdjY0kzTUxTRjc1VkhnUk5x?=
 =?utf-8?B?TUxaRjVKczNtUFBobUNXUjNmTnlwM2FlN3RBaHdpVFJPb1gvVnVEYVBVTlEz?=
 =?utf-8?Q?6Bz2zguTFv7iwe3O80?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eea1324-2aab-48e6-f4ab-08df1a236bc0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:05:54.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSwGdWMeErVLFOVBYryXp70tM0tW3Yfl2TJREP54Euf0IJsPQIN2HEpsgSuou69s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684

hi,

On 9/13/2026 2:06 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>
> - [Medium] xlnx_tsn_ep_probe() and ep_parse_tx_queue_config() enforce two
>    new mandatory device-tree constraints that the in-tree binding does…
>
> --
>
> net: xilinx: tsn: parse endpoint DMA channel configuration
>
> This patch counts the TX and RX MCDMA channels listed in the endpoint's
> "dma-names" property, allocates the conduit netdev with that many hardware
> queues, and parses the "tx-queues-config" child node to map each logical TX
> queue to a physical DMA channel.
>
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> index 089f17a126f5..24025b1f6e66 100644
>> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> [ ... ]
>
>> @@ -69,15 +88,173 @@ static const struct ethtool_ops ep_ethtool_ops = {
>>   	.get_drvinfo	= ep_get_drvinfo,
>>   };
>>   
>> +/*
>> + * Parse the "tx-queues-config" child of the EP node. The logical queue
>> + * index is taken from the "queue<N>" node name, so the mapping does not
>> + * depend on the order the child nodes appear in the device tree.
>> + */
>> +static int ep_parse_tx_queue_config(struct xlnx_tsn_ep *ep,
>> +				    struct device_node *txcfg_np, u16 tx_present)
>> +{
>> +	DECLARE_BITMAP(queue_seen, TSN_MAX_TX_QUEUE) = {};
>> +	DECLARE_BITMAP(chan_seen, TSN_MAX_TX_QUEUE) = {};
>> +	unsigned int count = 0;
>> +	int ret;
>> +
>> +	for_each_child_of_node_scoped(txcfg_np, qnode) {
>> +		u32 chan, queue;
>> +
>> +		if (!str_has_prefix(qnode->name, "queue") ||
>> +		    kstrtou32(qnode->name + strlen("queue"), 10, &queue) ||
>> +		    queue >= ep->num_tx_queues)
>> +			return dev_err_probe(ep->dev, -EINVAL,
>> +					     "tx-config: invalid queue node %pOFn (have %u queues)\n",
>> +					     qnode, ep->num_tx_queues);
> [ ... ]
>
>> +		ep->tx_dma_chan_map[queue] = chan;
>> +		count++;
>> +	}
>> +
>> +	if (count != ep->num_tx_queues)
>> +		return dev_err_probe(ep->dev, -EINVAL,
>> +				     "tx-config: described %u queues but expected %u\n",
>> +				     count, ep->num_tx_queues);
>> +
>> +	return 0;
>> +}
> [ ... ]
>
>>   static int xlnx_tsn_ep_probe(struct platform_device *pdev)
>>   {
>> +	u32 rx_chan_num[TSN_MAX_RX_QUEUE];
>>   	struct device *dev = &pdev->dev;
>> +	struct device_node *txcfg_np;
>> +	u32 num_tx, num_rx, num_prio;
>> +	struct device_node *ip_np;
>>   	struct net_device *ndev;
>>   	struct xlnx_tsn_ep *ep;
>>   	u8 mac_addr[ETH_ALEN];
>> +	u16 tx_present = 0;
>>   	int ret;
>> +	int i;
>> +
>> +	ret = ep_count_dma_queues(dev, &num_tx, &num_rx, &tx_present, rx_chan_num);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ip_np = of_get_parent(dev->of_node);
>> +	if (!ip_np)
>> +		return dev_err_probe(dev, -EINVAL, "missing parent IP node\n");
>> +
>> +	ret = of_property_read_u32(ip_np, "xlnx,num-priorities", &num_prio);
>> +	of_node_put(ip_np);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "missing xlnx,num-priorities\n");
>> +
>> +	if (num_tx != num_prio)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "TX channel count %u must equal num-priorities %u\n",
>> +				     num_tx, num_prio);
> [Severity: Medium]
> Can this equality check reject device trees that the in-tree binding
> accepts?  Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> describes the two properties completely independently:
>
>    xlnx,num-priorities:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 2
>      maximum: 8
>
>        dma-names:
>          minItems: 2
>          maxItems: 16
>          items:
>            pattern: "^(tx|rx)_chan[0-7]$"
>
> With that schema, dma-names = "tx_chan0", "rx_chan0" together with
> xlnx,num-priorities = <2> validates, but xlnx_tsn_ep_probe() now fails with
> "TX channel count 1 must equal num-priorities 2".  A 4 TX + 4 RX endpoint
> under xlnx,num-priorities = <8> fails the same way.
>
> The queue node checks in ep_parse_tx_queue_config() add a second constraint
> that the schema does not express: exactly one queue<N> node per TX channel,
> with dense indices 0..num_tx-1.  The schema has no required queue children
> under tx-queues-config, so an empty
>
>    tx-queues-config {
>    };
>
> is schema-valid and gets "tx-config: described 0 queues but expected N",
> and sparse names such as queue0/queue1/queue2/queue7 with 4 TX channels get
> "tx-config: invalid queue node queue7 (have 4 queues)".
>
> Because the endpoint MAC is the DSA conduit referenced by
> port@0 { ethernet = <&ep_mac>; }, a probe failure here also takes away the
> three-port switch, not just the ep0 netdev.
>
> Semantically these look like different things: xlnx,num-priorities is an
> IP-wide traffic class count on the parent node, while dma-names describes
> host-side MCDMA wiring on the endpoint node, and the binding's own example
> uses an arbitrary queueN -> tx_chanM permutation.  num_prio is read here for
> no other purpose than this comparison.
>
> Should the binding encode the coupling (required queue children and a
> dma-names/num-priorities relation), or should the driver accept every
> topology the binding advertises?
   The binding intentionally does not encode the coupling. 
xlnx,num-priorities is
   an IP-wide property on the parent node describing the number of 
egress priority
   queues the IP is synthesised with, while dma-names describes the host 
MCDMA
   wiring on the endpoint node. The equality holds in this MCDMA-only
   configuration, where the driver sets up one MCDMA TX channel per priority
   queue, but it is not the meaning of the property, with the time-aware and
   per-stream schedulers a priority queue can be served without an MCDMA TX
   channel. Encoding num_tx == num-priorities in the schema would 
describe this
   configuration rather than the hardware.

> The YAML is unchanged by this patch and by the remainder of the series, and
> only the 8 TX / 8 RX, xlnx,num-priorities = <8> example in the binding
> satisfies the driver, so dt_binding_check does not surface the mismatch.
>
> Could the commit message body state these new device tree requirements?
> Right now they appear only in the below-the-line v2 changelog:
>
>    - Require one queue node per tx_chan and num-priorities equal to the TX
>      channel count.
>
> [ ... ]
   v3 adds required: [queue0] under tx-queues-config, so an empty node 
is now rejected at
   dt_binding_check. The remaining constraint, exactly one queueN per TX 
channel with
   dense indices, depends on the tx_chanN count in another property, 
which dt-schema
  cannot express, so the driver validates it and reports it with 
dev_err_probe().

Thanks
Srinivas Neeli
>


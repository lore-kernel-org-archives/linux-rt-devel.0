Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E308200110
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864832; cv=none; b=MS+0Mo7JMkfa50deWnh64JGk+/5ofc0pwZlDv8nH3ppSo9JqaWdaY/gCw3GgmWP3xc4c6VaAJJmxG0nTgPQABmNRMnomagvZAVFvcnVPKqpjyfC/sXAQ6HAdT2vQzd/f7gOkZWQPQpX/kclqEgci6n6mvCD2ikMfKQ7J8mqkGPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864832; c=relaxed/simple;
	bh=4j4NWGPFsHfvtb4eIQbqLKEU5VRM4jl98L1Wy5B+oCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFy6hr2DBwOZrMSoVnYZh4d4M16XOwOJM+f9WKdyOOKSpxQm8Yw5hwf0qdbcT+LewnaFjdTIl3C5AhD9TfzaURgW29ee5ffZ8vh3hEugYm+06qNnx9alZWm5+NPWZYqWo5Z4Qe/8z8GBcX33Mgqj/Y6jzkkX3agIkvVpfQJ6pYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JWwBRp5y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QFqwvcd4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JWwBRp5y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QFqwvcd4"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MAcwLR2123520
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 13:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQ4bPzlWEYxjbJF2kreOp9MPUnQ0acpYT1N59TN47uE=; b=JWwBRp5yiYEvuszc
	5vmuY0T+vuGqB9GymLxDU3t6ZHEXTjN1eugjAvaNYTJu4gsBbsVurHzAr7619j1O
	1QUW+g4uaewoD+p8bXMctqnFIr+UkWjIPofLJl/YK9cQF4Swx2HbrfUP3hCy0j5I
	eDKySbiBcE5GtnUOrmuWaqdw4V8sb3nyattc3OmArpr+qEXdmupK+qxf9M32WGzn
	495dKQ4V3VZpP3c/wT8nJz7yb98dUydHUfNxSdI9C7igW8uOQDOKRrP8HilZi2RZ
	WyQKWbFKgjrwBJu8yU0FKG9iKa7dYNn/A67Tlb226BCHvE6dD6cru/lyFbjVXyRq
	sLMcEw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfujuk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 13:33:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2de07c12745so5078196eec.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776864829; x=1777469629; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQ4bPzlWEYxjbJF2kreOp9MPUnQ0acpYT1N59TN47uE=;
        b=QFqwvcd4CO6TLt6bUbfQyA9mAgFFVW5gUhpV0UWkK/GlZdM1JcORZY1GusQM2JXEb+
         T5yuGa0D7IG6jf0D7fNo+VkbI1+M0DSx4GQDVJrC32ztojl/fiZSyd/ZiwUu6wqaZk6E
         uy81OUczyHHuEQ+JQraWrPMbSJfKsx7cnmr9+7wU6P77Pm/u7tywPDtNsKTRbxRjR6q4
         97tr8XiddhtTk6W+q1bK7PCaXmYX461lIaZ0RxE3J2eiQaNtVKKU6Lqm6eScEv/+702l
         czsI5TpellkYWOncwNNNkfdX5I3wq+uovVHpPiL66NTKOVLIEGiNy+KIecyIp/0Gvsoi
         mBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864829; x=1777469629;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ4bPzlWEYxjbJF2kreOp9MPUnQ0acpYT1N59TN47uE=;
        b=WBMFU5J14RdaJZ8GMvWczihoY41hxkL/NEw1ncrADZTsc827LfrDVohFiY7LTbykpU
         GOuMJVj7r6cTolKWzAtv/XNgxjhZy8GDbnuFI3tO6V3K5D3dxwXi7UF4CBOARAczhXiP
         2GPsr6K3GAe+8KE4olyX5cVYAHxgwSV0ceTCVFcX6r18uyryKReGrVWr7pn7WT9xYG5g
         +lVM5hQM6QZVCswRuBvIE/mtqlZCBhQy+hje78GCAvwwptq74+reTr7JxXm4hcU/5fY7
         ZBDBICoavXARHRdiP718XBWEyXz9iDOAC0zt4GSyuh66Do6quzRXd0EnRXTp1wLZ+3oE
         PPBA==
X-Forwarded-Encrypted: i=1; AFNElJ/UNSShdMbHF8O8txIkYXKyfaW3xH38BpsupKerMpOqwZgCVLXoE3Se49y1LXQcF+j2/kf3rYoE02J9dp7W0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvhVjiuGdCExPUxQ8VyLHCdEikTlKVJkdzc4/jf9gWHfASXm97
	F66n7X5XhQAxH/pMPF63rWDfcHKwS2N9Y5tC9UGrQBO1ozEZnNN4QGSSMPK9DybxZDbna30U1D7
	Q0n7vx2Zi2FMJEUVX/VqZcw3FogZ12xug+R+/9pYgyxtlWIz3eXDpA9w8KhElZVDPquSbHQ==
X-Gm-Gg: AeBDietgpPLQyWdTuyKL0U0SqWjB8NBynwjRzhl7ajZNxQiVjzepO5i9rZmAjSrgODo
	0RdaP1i5Y3a5Wb3iJznUzJHqLeadcFol2k7sjpTCmZ7WvyEF3De9vLKtyo0UDI09uiqgk/4AnOI
	fWbmHarPSmZ0NFGPYy10S391NZsvdZh/UREIjQXnhHpQTGTLzAz9piCn9lIqEpnTqQ2YZwlywch
	mwWx15kuNE2t12IPmnaUA6h6ySRwGTuwuM0SnniFZInbCuUxvnNR8BZQXBlwU5zul9DIAF9uapC
	pe1FY/glOLNwJZCh5zqJ7JSmFj/OW31CXePGvRgvkwvNOKqr5fJUL8avCqnuAhlk4+n3W2wM3wf
	Xlq8FScDzKPeBL1rhav+Upe7gJadYexnjuuf36ySeumbhBfETR2afrPA1mxFhDOeNDVm01cg6Sz
	r49KA23Gguzm4kLyo5
X-Received: by 2002:a05:7300:6c27:b0:2da:1a81:5ae with SMTP id 5a478bee46e88-2e475b3994cmr13676064eec.10.1776864828564;
        Wed, 22 Apr 2026 06:33:48 -0700 (PDT)
X-Received: by 2002:a05:7300:6c27:b0:2da:1a81:5ae with SMTP id 5a478bee46e88-2e475b3994cmr13676038eec.10.1776864827980;
        Wed, 22 Apr 2026 06:33:47 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm22934305eec.21.2026.04.22.06.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:33:47 -0700 (PDT)
Message-ID: <5209fd4c-eee3-46ed-b731-1e822a04b03b@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 06:33:45 -0700
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on
 PREEMPT_RT
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
 <20260421172500.1050754-1-asas1asas200@gmail.com>
 <a396cf77-81ff-45a7-ae62-fb4e22c18497@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a396cf77-81ff-45a7-ae62-fb4e22c18497@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OdioyBTY c=1 sm=1 tr=0 ts=69e8ce3d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=t_iSBFEcjObAjGY-HZQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: JawpYwQTzRGuDMpRsgFoW9TMwIv-k6XV
X-Proofpoint-GUID: JawpYwQTzRGuDMpRsgFoW9TMwIv-k6XV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzMCBTYWx0ZWRfX4bW0H7wAwBoh
 UV9os0Etst7fz8lIhW4ecRembaI69l7QuzWDDX4jhkdfPy96QUtwPxfv58zlkkQn0FI73fdpAS7
 L3OgpfKjutudFh5llW101hEGonvtPCdvhlAUvi2XkABIcVo6oDl+h/J4sPKI0P39+oIlaOpZWe7
 oTzDYT/hlXmPw741Nnug5UA546JwfVr9CHtQl9inKWWn+/3If15eNG2ZAduJ6jCNgr+j8rLN6EV
 g6V+ycg57k6vukhnZdE6WOQ0Dos8nmfC7kCDrKYWp3uKsRLYdIm0v8ZBdv/rQEpceC3orKA6kzH
 7kmT6EgxLhRsHr+4AFTLnKCQtOIz3e5J31+UTbEiUyuIe9Mjha8KohEI8nl7M1AWMDSmnev4NSK
 /8pobqyzgNe2/KUQGP1hCQwSrSLHVtoYr0w22Ad7BsCIXSvUrN29YpvinsJVL3bQFDux/FBXXR5
 I+5D00Ag3LBl2VODXfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220130

On 4/21/2026 2:27 PM, Jeff Johnson wrote:
> On 4/21/2026 10:25 AM, Yu-Hsiang Tseng wrote:
>> Two functions in ath12k assert that the caller holds an RCU read lock:
>> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:
>>
>>     WARN_ON(!rcu_read_lock_any_held());
>>
>> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
>> false positive splat whenever these functions are invoked from paths
>> that do hold the RCU read lock (e.g. firmware stats processing or
>> mac80211 interface iteration).
>>
>> Root cause:
>>
>>   - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
>>     returns !preemptible() as a proxy for "in an RCU read section".
>>
>>   - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
>>     task can therefore be preemptible while legitimately holding an
>>     RCU read lock.
>>
>>   - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)())
>>     and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
>>     read lock, so these warnings are incorrect.
>>
>> Typical splat seen on a WCN7850 station with periodic fw stats
>> processing:
>>
>>   WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
>>     ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
>>   Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
>>   Call Trace:
>>    ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
>>    ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
>>    ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
>>    ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
>>    ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
>>    ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
>>    ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]
>>
>> Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
>> debug_lockdep_rcu_enabled() and therefore compiles out entirely
>> when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
>> full lockdep-based check.
>>
>> Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO handling")
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Note that Tested-on: is not a official upstream tag, it is an ath-specific
> tag. Since it is not an official tag, it should be specified separately from
> the official tags:
> 
> <commit text>
> <blank line>
> Tested-on: ...
> <blank line>
> <official upstream tags>
> Signed-off-by: ...
> 
> Unless there are are other review comments there is no need to send a v3 to
> address this -- I can make this change when I pick up the patch.
Amended patch in my pending branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=32f70ee38388bb9089b9cffa9791f5ef8d5d32cd

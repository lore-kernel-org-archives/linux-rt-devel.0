Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D82236E3
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792774; cv=none; b=Tz7JkGiWklY3vdU4yuPqxZaa6fGvyKb+pYjXSmu3B+O9fCvZLtJnukUjXEhP20/zFXxbypG0S38+STsElPOl6tVCZV8cY6Aq54NrpOwkIHUM/O2I/zJ9KjYpAt7gz8h/lCwX65YqKFG/x45fy5n6IQoEELIPm49sZ/UDrh413Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792774; c=relaxed/simple;
	bh=/Ba3EWb30hnk7KFV4mh/GjZJGnrFEQ1WOb7ya6fOX7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0FaJ1KGkmkAZKhDHl1f/3UaXcsHywf+B2ibSgBAwuy5P7Py2z3oWL+j+KiaYVT+M6iOcESBNJw1AHNMoueBwsGgnr51Dxa4bZs6357Rs0eVfBbL5RPqgL34gBe6rFHoe4lUqAYkzKPrYLus5N/FrUAAEGQUxHYGFaLPFljZXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QS1e8+mp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=axfp16Jt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QS1e8+mp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="axfp16Jt"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LGYb8W4167765
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 17:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	URbrxLq/NhhyYFTtqjb5hgyP/ewhb68e/QnrFe61sLQ=; b=QS1e8+mpvTYDjLbI
	xBjSEijM1o+jWC55zG9SWLVLY83eP+tP725VAEMlhVXgrcn+abz3kKFGYxGcZS2Z
	nGSkalD/gFqNdhkCNZrhy4it6WuRCW+iPpJYayUglXGT6Cbxn/kixJ5iDld5vNIs
	lIWhGLifnNHQdWbQyKJtrjSG/+3qr/XCsbfx85cOg+ZzNdkQymT0hD9CTabVefrF
	5IHeVJYJi3GJdUEAaWnZYUIY1+zZtddg0aZOAbWaFeNXNSENAl9EsH3PgMiLIN6t
	n2f8vZWfZAihWck1OOoTbAfdnCIdKr24JQpmTr+Qs524pDnDLz+D9EUnnsVRSKk2
	EJ2t2Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp1au340a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 17:32:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76bfd7b9cdso1662460a12.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776792771; x=1777397571; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URbrxLq/NhhyYFTtqjb5hgyP/ewhb68e/QnrFe61sLQ=;
        b=axfp16JtLvNHuiA22L5O9y5CfqI5yCHfKw32bxUS9IRaf1X2FAw5xD/eScYUOTsC9d
         rHovy04MMaWkiH8JLdBsqH0fYS68rpMiWXdVa02vdvWiKCiawLClzqPuacty0D+OvHsp
         92MdFjRbZtECF9HTMSyOQ5KjVtBJrUVHxsDbGMx6xNOGWXZh3KBKTD/u5EzBSC2mysBS
         NS5xQI0rZVcdpLayyCcV9tYOI3qIjhw1na/+FUs8mEOw3/M4APMvlEUPmqPWDIHVwKv2
         wM7ip1EZ5gTStF19qMKwd0/rGGC6MroCKBs0sKTDJlK7nEtvCqxTL+oyuJP732QwIEKv
         2XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792771; x=1777397571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URbrxLq/NhhyYFTtqjb5hgyP/ewhb68e/QnrFe61sLQ=;
        b=dP8zeWFgPYBoqF3iWlfN4+Q8r0pzj7vHx6t1+r7Yhrxvo3DdfyTcxVw0JnQjiRLOF6
         Z7B8efwX36diLK1JTBwPN0hpieL5y4RgLwk0N1suBTzcngKS8i2n0IckmGhSY90dpQEQ
         QfgTUkmUYyUVQVvjZqFdl7gYSdb7QpAiyRyFrjqlOnzURI768Z4KZVO550tIUQZz0t7J
         ztTE672i1EhIMIFijY8fNxt5UUVwkv0M1wHsjHI5PnxITST1f75lwsIpzITwphMnTeWJ
         RA0m2hyE5bXNWmG0ukSKwqu2MFqFkn049VJykoJuNou1ME8vzAhTyMK7eC/WwPWJUE6/
         S2Qw==
X-Forwarded-Encrypted: i=1; AFNElJ+GndSQ5tMqh0vyZg8+XO8cBEZCQYrCKyJZPEagZOL0idJelRpCiWMl6LmvL94TaRBEqnKYOazLY36FoVJ/PQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2TJN08/Y3smcmo+9UC0GP1575E7BLQKRh4n/qR5mScbPV7+73
	ZwYDCvUcPUgxRyVJGhlzi+ZffaoOXxc5p0ehqwI40f9slagh0tBec1jLuqnEAi6YeymxAz6Q33f
	I5zwbA1YX9OqchPh6c0Sf0LD6sVlwVdTPZmnZwriz+V0d7VymMPlSm5/xpJvfytPLaueYmg==
X-Gm-Gg: AeBDievPQtC6jzSUchUSWudZffdXRwqL/KLkY0ON9EQOMCDvyOTxXZ+c3wIfSw1sp2e
	ZYbq9nzTSSwdYhPwLMA7+5laiQxrqRuxek/tDAuaY4yyTJ3Fe3Su4uAK+nbqiSA5uPPIJ7XoGXu
	kSGygXJXLh/65VO7msv49iCcGyyAgLqFTCBCa9EVWnLe381J4S2mTgy4/yeBkceea+92b7yYpvS
	qenD5QrHzqXM6VRgzaUHM5YticsVhMls4ZXnQyDL2LIiAUzY/TgdXssW2xDN/TzP3fmrWb7nsyv
	i4T/bm5or453yM1+L5V8pjIYxPXrfU4YkzhykndVKk/8K3Mg2i5tsMoiid/QbuAcNHr7Q8XHWTx
	R7CCcSFCmhUFqGz0o/G+b2264SEXIBMKgnAMAGFpQvvcb1n9eAA1Kncfqp3YR92DYCHwTwihQZn
	Bj
X-Received: by 2002:a05:6a20:4326:b0:39c:cf9:b8e4 with SMTP id adf61e73a8af0-3a08d8f5a50mr22898220637.42.1776792770674;
        Tue, 21 Apr 2026 10:32:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:4326:b0:39c:cf9:b8e4 with SMTP id adf61e73a8af0-3a08d8f5a50mr22898185637.42.1776792770063;
        Tue, 21 Apr 2026 10:32:50 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f3e5sm11200099a12.5.2026.04.21.10.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:32:49 -0700 (PDT)
Message-ID: <1016fbd7-be27-44b1-9eb8-6201c9495f1a@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 23:02:42 +0530
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
        Kalle Valo
 <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
 <20260421172500.1050754-1-asas1asas200@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260421172500.1050754-1-asas1asas200@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3NCBTYWx0ZWRfXyUOOVJjpP6gd
 Ft5D8fQ9Dq63TQ/IlZholgEo91vMksDkL0a7hBwnhPc7OaZkWibMiLGzh6qNHyHXc8Kfjf8IkLJ
 9qalXfwMnE2v79Os04HgazgPeH43EEWnpFHC0k3W0vRTlZ4nMrnCvzfVu0b3ya0pPFb6JpRKrrh
 pZbc4vXY9E7XPp8bN9bEy8lNmvHCn7H1v6se4NhLKfJ/2Mtm1b4aSk8s78WNlbX1Zb7vHX1KGjc
 ebfZC5HcwHpK7RNwbVvtkIDi0eAKm2PLJ3bv2479HwhSFmB37v1FaDXTO3a2xj6Op5P1x0U5Cad
 /Z58/fPxO8eAEpuq+t93aTP3aueLuRNPdqk29WakLxgBqNAA+MxSZSJEAcvVvbVH2Ng31+zceO4
 2/JIYp2FNSAZK+3oyHl1n+CR0dv+n/PWYV+MOEwcPJdh3mDdVyMqn0guO20vw02I/TJNDeB7rA1
 YO+YsAx74/AnrhBDzQA==
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=69e7b4c3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=akWcTCgZTv-KWhlo_GAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: zsUb0SUHCiVLSayzbpjDpX8ycRHIeV8N
X-Proofpoint-ORIG-GUID: zsUb0SUHCiVLSayzbpjDpX8ycRHIeV8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210174

On 4/21/2026 10:55 PM, Yu-Hsiang Tseng wrote:
> Two functions in ath12k assert that the caller holds an RCU read lock:
> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:
> 
>      WARN_ON(!rcu_read_lock_any_held());
> 
> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
> false positive splat whenever these functions are invoked from paths
> that do hold the RCU read lock (e.g. firmware stats processing or
> mac80211 interface iteration).
> 
> Root cause:
> 
>    - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
>      returns !preemptible() as a proxy for "in an RCU read section".
> 
>    - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
>      task can therefore be preemptible while legitimately holding an
>      RCU read lock.
> 
>    - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)())
>      and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
>      read lock, so these warnings are incorrect.
> 
> Typical splat seen on a WCN7850 station with periodic fw stats
> processing:
> 
>    WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
>      ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
>    Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
>    Call Trace:
>     ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
>     ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
>     ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
>     ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
>     ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
>     ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
>     ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]
> 
> Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
> debug_lockdep_rcu_enabled() and therefore compiles out entirely
> when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
> full lockdep-based check.
> 
> Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO handling")
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

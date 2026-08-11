Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446EC35838F
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453145; cv=none; b=YulXfsrQ3Q/91ITE8O7EoKLf5fHFfRzXXmQOMiVCrgOlhkBBhs/pZ72tp+O6Zn3s6CDMHUvhDu0o03yxG9tJjFfSP95zcfcysYt2b3eU1Z8KdcHSUb+LzbzbpXSotcvzt7vPRzpBYhYOeXaNMIWFl94CoL6zSFEhWNpvD60Yqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453145; c=relaxed/simple;
	bh=XKKJd3c9rLa3MO7JUMHEIuKamL4nzttlvV7UC1Dbh1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T57MAV4jRZm1F72x96l7srGBYdZPvM11mqifkTYwFvGS6XGnF4wQVjlYC+1D0IwZuS+XLew7vd1bGpsc3NL8YsPM4s7ToXv+5E0jP/0ICVOW+Jl7iGBggjdunayoUmmDLlZ4/nueFvKx3TRmzNMmcEXKoO6XsR8438UzL03SfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iU1EN3xo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SVU0zhv7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iU1EN3xo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SVU0zhv7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BCRRpA939943
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 12:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d1LOAVLaXvcUVOUS5kxm+cqp
	igoXQ1JOPQ7twMHVr0Y=; b=iU1EN3xoWsCdt5slHS/V8ooTbEcxkSr3mbxofmAS
	NOwPQDBANNlr/mYmBkoIn5nRrishL4kq83uU/vxzZINFCCPNe6eH3htTynhPg2Am
	1qvrkYFXeJpvJlUD2/YqUgwdt7ucTrZh/E0fG2VV1tZp4DNWPGbpiNCLc22ynyEV
	pkwr/1fm0Nn+6PU9sqFJiZQ6MdpF3ydnwAkdRFRfyRlQbEibqOi07weCUSaDmJ0M
	reIGhEuI6Aqm96BDU4E6jhlwdQLtuL3OX10AryGlihqifDzsqY3Huou4NhGJmkvU
	Ym0kXEkLtA8xqUj7ffK9hHeFgS+nZoC5o9MFYhjJIIA9Rw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyfv2d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 12:59:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so9071011cf.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786453141; x=1787057941; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d1LOAVLaXvcUVOUS5kxm+cqpigoXQ1JOPQ7twMHVr0Y=;
        b=SVU0zhv74xqa4MuFmWGXwWsma8enmKzbBPUg3pPM1x/F/xI6g556em3TpFgzMxY/Co
         BjUjDRzfgOTDFIcYXvEKVTIUPpPxJvnMF0bNErhBQ6QOZ5IssDS9zAunCcjIvqQ7Aw1H
         RE4/5VbhZ3zvin8hRH9OR4PanTnXdJhVZurvjbttvX2693ihCvrr4wtA2trQQrtmvqB/
         H37UtQnbxaXKcWhObQpp7dnIQLDPNm3O3szjV3Ssm3rEcD5Y6X66pHVlV66XSYxYhPc0
         w+Jcpb2ISBn35RyJ5mW6QQj5YjCpLp+FnC97IAiMD7gZL8ST1vIHADsO7c0ercTFR7EU
         HxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786453141; x=1787057941;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d1LOAVLaXvcUVOUS5kxm+cqpigoXQ1JOPQ7twMHVr0Y=;
        b=o3ubkDrK5xbkzPpKbGD5zXnbiwUR7DM1cCbE07rDK8JtQUDOtXdaFly1osOqqLm1B9
         48Z63KsPPFfH5Oc2sVYvILLyWEi3s+03qHzqMiIdqcURTIdFklCWNaAWUh40xSSLHCGh
         qqjuLfPtbkyzJsNsJPolNezhCemzunJbkKaCUboZZzRNlSZiV8M/taEEjH1bBVj7z7DR
         bnjz0pXkTTLUbEvwOp/HxbDq0tiQj+Lh6UipclVFAAWwTFgFxPgyVTjjAe9KBEXfljca
         n2XAUGSCocaqBEKqSPkT3svLFxWUiRv1UaNe8rZ7pQVMt7z9VaYlAlF+dTh1s4YLE1aC
         dddA==
X-Forwarded-Encrypted: i=1; AHgh+RpFGP2vMLBWxedFQVscV1l5o8EnFsDDB8my6DWrHJlQi7a1SIawO1wb/9AAFeR17U09cfaCgq4EkTcAvTnylw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCDgSRBopIAE9YNHoygmJz82rUzHhirjaWfcysvNAy0jkyqYFg
	ekh5e7F7CV6NU7sgvd8vWH4INkjejSmNA2MZl8M8ybFR3M0nBJJS5f46JIWef+GpqS/K3ZLiw9C
	kzjP+s9UB5BTZsFUd2aDFeLfFiUvuMMcYTQ4RoFmHG0giDJynEd3KYOVIF0fe7UZqjPr2zg==
X-Gm-Gg: AR+sD115QiEcibuo7U51PXfEpkqp1ijsH/F7b6jcv91GpUq81zCDn4pVwCZsr9FP/Zd
	tHSOGwFVoC0AZhSVqc9CbEgZtPxfuS7jPHj3tLBKTijmHTTPV5XqFaGmW0Z6JWvOPB0gf3vajYj
	M9TQNchp5Tv+0r+GcYV7Q079MqECNw+Z8pTFokof5eqrsG92W37L28M4VzDmDYedCGapc6099Mb
	ilYOvyVq9ujY1dE/9uowwZ6qHxxw41x7ok0GuaZmEgMyzwWQ8xxbM5M6TVV90Hg1bnuSoVtnRP5
	nqaxb92/VEf9K85Mj8m23gL8YjS4ag+OFUlCKq4x13yWrrgLnqDMY/BoPWu4U6OABMfi64J0BTR
	OeCivapcmRviiXfOMfWbBaKNFpesvs0ZHx65TRTPokkArn5Uvyzlsrpg267YC4koYtLNSghP8mE
	HBH+nwviqiQ89sxA==
X-Received: by 2002:a05:622a:491:b0:51c:1e69:bcc9 with SMTP id d75a77b69052e-52d600e6aa5mr54161cf.12.1786453141380;
        Tue, 11 Aug 2026 05:59:01 -0700 (PDT)
X-Received: by 2002:a05:622a:491:b0:51c:1e69:bcc9 with SMTP id d75a77b69052e-52d600e6aa5mr53781cf.12.1786453140902;
        Tue, 11 Aug 2026 05:59:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a0fa3fbc84sm2423781fa.14.2026.08.11.05.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:58:59 -0700 (PDT)
Date: Tue, 11 Aug 2026 15:58:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jia Yang <jia.yang@oss.qualcomm.com>
Cc: Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, jie.gan@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] mailbox: qcom-cpucp: handle NULL data in send_data
 callback
Message-ID: <gkju5hkg2r6nveirwe3bzeu6onezx5wxnkd6rxgn4lsp3uox2k@dn3crxwncft2>
References: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-0-d302a63dfb5e@oss.qualcomm.com>
 <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-2-d302a63dfb5e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-2-d302a63dfb5e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 6OoYwbB1iOcc6taF53hgPvzoP3juLM8R
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwOCBTYWx0ZWRfX1f2QVPEpaRxm
 eMgokmwqTYQGVa1ketSu+T1vl92NZoS1soQ/2u3JnuGWOV0m/ht1SYjt+/pEloHDlI2Z1Rz53sy
 IOL+/qbV+meYTLLGNu69oeNGGR99a4Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwOCBTYWx0ZWRfX5/5jPLun3ouj
 2gLs0BhozpsQvNkgNcm7tO/fyELSBhqo5vYdrzcZL8s2v+s2Kic55qBJcTQfMoAOm81NJ56ao6v
 yVwm7/dkN2q0A8o1t/NoezSVZRjNfBskRisuG5wZDwk0AAyK9EgzbdAulWa+SNa26KjeiiLLyG2
 rBII/ARVezSTfB9HfKj0M6febUJq0Tdc9q7/PZq94bei0CibhzgZ7fQxThyUT7BFU2etJ8rANmY
 eGVd2vevmr8XO4gkEgvLaDloAcOZ2JPP9pHIYRSohD7hDUTM+Eq53yRSe8w6KEAiRa7V4jzeARb
 tRmK5//Y1XbLo8KoJsd3+migdppmxhfY6xNlIy29xW3xrRC0LLV02x4RvuDgMBRL6wi+tsvIxhD
 MWRe/y5nLzBiisH2xagM+C/j0QeUsiYKozbs39pPT/9oaSrUHMAxQQ9dnZDI/0n26bO0pJT0ZTm
 o8pmdgPsIc/Y8LvBjQg==
X-Proofpoint-GUID: 6OoYwbB1iOcc6taF53hgPvzoP3juLM8R
X-Authority-Analysis: v=2.4 cv=Zd4t8MVA c=1 sm=1 tr=0 ts=6a7b1c96 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=TFpumMFFombz6g0OY4wA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110108

On Thu, Aug 06, 2026 at 03:03:57PM +0800, Jia Yang wrote:
> mailbox_clear_channel() calls mbox_send_message() with NULL data to
> notify the remote side that the RX channel has been cleared.
> qcom_cpucp_mbox_send_data() blindly dereferenced the data pointer,
> causing a NULL pointer dereference kernel panic when invoked from
> this path under PREEMPT_RT.
> 
> Add an explicit NULL check and return early without writing to the
> TX register, which is the correct behaviour for a channel-clear
> notification.
> 
> Fixes: 0e2a9a03106c ("mailbox: Add support for QTI CPUCP mailbox controller")
> Signed-off-by: Jia Yang <jia.yang@oss.qualcomm.com>
> ---
>  drivers/mailbox/qcom-cpucp-mbox.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

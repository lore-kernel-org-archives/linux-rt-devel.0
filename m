Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25873D811B
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Aug 2026 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966347; cv=none; b=YWSGjLE//8kaxTdUb/KO+bgwCZJC99bK9RdOJXihzbxA9HYpiDssr9WndyO8YnYAltcWCTMNso39VV0QrJPkWX9Kygq4bOO83kzLlJaZ0BQg9ZK8KqN3UvQ5DMsSUX+DO7at9Pf3Ujf98UnHqZLnuopogMHefnZH7yFmFA8cuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966347; c=relaxed/simple;
	bh=bVPz9xwPnm8MyNGvI1t4NszlI8/kOx9b3DAwpRJ3euo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMCortANsH0s7idkJsJRRCmsg/z+R0xNtkj8G++o+jaWvJNluoq08hNeEqDJWB+35TVKF+L6tvL1zY3J1UZf9WeP2f7bNUhE/XjkWwGmTQx5+YQGV8OBVdxAO7r0Sts4udheNcxXPsuhpxEqE++zCphi9NqgtO3I3EF+Kmxh4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cfEuuVte; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NAehKrJV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cfEuuVte";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NAehKrJV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H9ddxr1931808
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Aug 2026 11:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UlQ3xcP5ufHpNW2/5jSWCV84GTwT/h9uzPyRS0XLkU4=; b=cfEuuVteD7DUiUkj
	p8bWG0puiWIxYMEqIgNs1ERUdO90efP1ig8Zw5KrFA/ra9NojyX7r7B8f0uOoOQC
	VBsmdfqSxRDYj+H4f4Cs5c/Zohr/DMr5eUwHfm0X7Epq/x6T5XCwo6uzE5Kpt+oR
	ub4gTxFRFkJqyfxvpAKNE/NtWvQJk3kZbaCKrI6CxnFb8Z/NIx0Mq3Hg8xFI9bf9
	wK/PnevH6nooXCWCoWRLyc0lgi+rtLrSDAj9svj8CXfoapg86gBU3Bervhzy45QB
	9viKHX4uZcuvWTgTM4M4faKHtlkpIDvfGJ1sDUi2N8OldmvUUPbPp3FyH+R1Chrz
	pRVFjw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3txy9m3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Aug 2026 11:32:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9058a836724so12278926d6.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 17 Aug 2026 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786966344; x=1787571144; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UlQ3xcP5ufHpNW2/5jSWCV84GTwT/h9uzPyRS0XLkU4=;
        b=NAehKrJV02ob1rDEPfatgBgpogvI1TiRA6/qhTqrmhtW6JKaE7fFkAWBL44aFhhiQu
         mDfgl+yoACcomnjpt16ex4+vH8OU41oS3NLtAYn9YobEcollbozKgukwQ+ELC2Do9/vX
         UK2skXfJkVjvr53hZxP1NCt+IIntHJSoVJknNa1JQQqO+k71UesmONZBl5lzRKtrKuAP
         nGd+dGBX651RofNW5nMxDbT3x+dQu/bXcF7B7XOfUC7Q2iRIDaH8NtkPWumVGq2v9wCn
         FLG2mD2RF4C30KSxFmNZvJ0vC8BBfAtFo9WMdOU09RUUvPNqOdNxcuC7Q4/w6kpNAZr5
         2tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786966344; x=1787571144;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UlQ3xcP5ufHpNW2/5jSWCV84GTwT/h9uzPyRS0XLkU4=;
        b=DANG84x/ZbXoolEySiv8fDBSFbXtlNYBRWik+DQhDiBuouTiiC2hoK7tZbh5o7HAXc
         Tqk/JFm3Khr8hRmsnsb3wYPPVzqczjoGxtSFFTnDmeEPoV40kBPxw6DKLquMsrdpaDW9
         wHkr8dRBK7AC+DeXqM4m2erhpMdWXzo9OWlg+sgIB/py9ITBrhuuoQfjEl6kmrUprgdP
         D6M3ZLH+up8gsej93uz06duzEGFyNJ2az8SJnR5/JWt1ScH1WPUInUQooWBcCXk2Qsz9
         UuxnuzpfNtlPaT0XzFYPBqtpMtxg6evRvVBVIp0nXkbP14uFxB9iaqap9CaZpckSUri+
         hu3w==
X-Forwarded-Encrypted: i=1; AHgh+RrIA8xRvQVt32JgQVE9Vb1w5/VUJmNEF9+FQgDtfmO/CF8h9t8YF4GAfb5IFh+8g3HaratjzCllKjwECzXzSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcDrc9ZCw8hqHOHjwvQPHaTYRzxPydUhgeyUNbJa09FvGLuEnP
	6ss0iqx8osW42N07zfgu3yBdoQ+/2mCs409nhYvy2ZQtSo07FN7m0vtVExSa54xZ6ekxhSrNZIQ
	s7RYpkvs6Kh/bF5+PqgnGvHF1n6yHItJjNUJf+TmRZJuER/u7ctoLImgevgPtsG3KeboqHA==
X-Gm-Gg: AR+sD11KK/0NGBd/+1HyCKPTt6JdA1GUt/qPfInSsEHfTlRZ+/SkisUJDTcULdERDhZ
	gmkoUCL6pNmcyWPSr8RRuBZr7PHpP4vToTDek3GGGidCfMeq/6yZdHaXYmgGIkVITuYltU64ilt
	xfxEC3N+Bwv7m16NC2TZ/RgjscjBqEQR80+Ea7W8/0EI/JuneDF8JVWEyBHmGCrNWYHsAtDgsm+
	OMTEYhb6Ddz+7x0alyYNsGTqMTOTPIvoz7nFzM0oIaNRKXBZtu0QLa6dtM9qxENzYewQUM6Ziob
	zikZ/t1yQtHl9zov8ht7mRlnn626Hg3to8BOv+pKw4H6Eyt4kVdx7X60B8XjTydHHasQYiHtH4s
	LTbU7HYCLpKVeIIEh+il7GXmD
X-Received: by 2002:a05:620a:6008:b0:92e:6071:7cc4 with SMTP id af79cd13be357-936d23a402amr1696931385a.4.1786966343888;
        Mon, 17 Aug 2026 04:32:23 -0700 (PDT)
X-Received: by 2002:a05:620a:6008:b0:92e:6071:7cc4 with SMTP id af79cd13be357-936d23a402amr1696927585a.4.1786966343412;
        Mon, 17 Aug 2026 04:32:23 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185bc66bdsm9381166b.58.2026.08.17.04.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 04:32:22 -0700 (PDT)
Message-ID: <7c902ab1-3b54-4718-aea4-fee9fa92c8be@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 13:32:20 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mailbox: qcom-cpucp: handle NULL data in send_data
 callback
To: Jia Yang <jia.yang@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, jie.gan@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev
References: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-0-d302a63dfb5e@oss.qualcomm.com>
 <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-2-d302a63dfb5e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-2-d302a63dfb5e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfX1jBq70Rkvh/T
 IALh60B+zIgOxPyqOhvMKs/Sbeo1CVR+vsFJg2NZAA6lWlEHCF5TZJP0IOUCrQaVOiLE0Yb+1+r
 qeQT2ubnp3Bb3NjfBs1lgjA+5i7nNxs=
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a82f149 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=FIVuYjU95cRvfn1gDQ0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfX54OxMZmDtFFv
 bAyXIvcE796mmpPP5bh1UUWJXNmY3pSZuFe3QxvmdKDZQqUEKYubdRI9pi+QnM+egeg9hSSvyfi
 bMxNNuOioXHmiF/POetz9e1iAuhWPB4kzyvihaZKt0IYVG1xoW7rkHs2NjRnNO1MHmK7eoSkBVp
 D2Q8kTyN8AuXAjqRuf4hl1Q3uVFDA2lN1Eg9YEL7eOtGHTfBqO0PvdVOMAD/EUVoBynY7UR+8nD
 GnVHNH8NlwPcdu86IWolOgD7FQUyl9TZ8a5ch0glHROVwv/plOjv3QhtYZ3dHgQ0/QWfJ997G/X
 g1pRl5Vi3NGUe6lNsgoCy7DABOeFtTuRCP8HFPGGQCYx5kZXCA1D5r4THYD0Xd1WFyQ/91+dTza
 C6fTPGdnlun3DDEl7XT3XpX6LwJTECCRTQENflTOQfsTzaz4E1wFxLhR/Vho+9J+BX/LePUNH5f
 msBdxntwpRRV1awFWxw==
X-Proofpoint-GUID: lmVTC7Ot5tB6jCbYbLE8eOh8BaPvVxfs
X-Proofpoint-ORIG-GUID: lmVTC7Ot5tB6jCbYbLE8eOh8BaPvVxfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170087

On 8/6/26 9:03 AM, Jia Yang wrote:
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
> diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpucp-mbox.c
> index 0f7fe189e8b1..298b357c0f9a 100644
> --- a/drivers/mailbox/qcom-cpucp-mbox.c
> +++ b/drivers/mailbox/qcom-cpucp-mbox.c
> @@ -117,6 +117,14 @@ static int qcom_cpucp_mbox_send_data(struct mbox_chan *chan, void *data)
>  	unsigned long chan_id = channel_number(chan);
>  	u32 *val = data;
>  
> +	/*
> +	 * mailbox_clear_channel() calls mbox_send_message() with NULL data to
> +	 * signal the remote side that the channel has been cleared.  Nothing
> +	 * needs to be written to the TX register in that case, so just return.
> +	 */
> +	if (!val)
> +		return 0;

Is this a bug in the scmi driver itself? Is a message with val=0 valid
as far as our mailbox is concerned?

Konrad

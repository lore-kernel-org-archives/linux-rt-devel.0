Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903123E44EA
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670775; cv=pass; b=Zl07i5AkGDf3rq8QBX4elzFhgoqMg0/JThq/Bw+hQWw/4gvlmrLEDg0XPnwZkwkLkpzM4f4+1vVSzixMPqlcEPD6eohorYQb+vUaWWU1zJj7xySUyR/e5vOh9F8MYtbit5OTCYE7AuhBEctc7mFZJZPBdXj5Jv1KDEXejMaOic0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670775; c=relaxed/simple;
	bh=rYdv04oG7QSSqQZeIDnFcGqjfR8SCbXpzGryBIgOyyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ok/PJFcxg4DAWEcYZuEvm7Km5f/Qyk+zcl0rYLGLJJy0LkxBn88NstePqiGTtwCfCcA9PNxx//MY9uzqnJMwntviORlLx6Rw44I/Q7Ekmpm2y+H4iw7VzCbRz2VShYYs7K7+HrF9ERvYDSKPeHxcfAVLtw1qLFzz+7kIRzZWgn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YeKF3eBY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IxTmFvia; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YeKF3eBY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IxTmFvia"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7ddMG040962
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 08:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rYdv04oG7QSSqQZeIDnFcGqjfR8SCbXpzGryBIgOyyw=; b=YeKF3eBY7YssdI5B
	/CNfbsjB3WeZZD+/j0hsm7M+BolNZGpNt8sFiZ1fxzS07wNM0fQsrgxCw5ozLsqP
	4nV0wSnGGjCvNTew1rYYpYpei9CkONTrO4qUP19uW6IF0ga0jOStVAigRgefukaE
	hmZGqAcJuwMQnRm2B4wwuNE3bPZfloEvISlHxEyVjQ8xUjvRkJd2MWf5nunb6432
	Q/FWQpqMKbVkHZkoHqmkv/fA0kw1GYQpZQxBd87vi7V8+yvDS3pBoX6h8uLCPjsv
	2CTY8BfzoycHKevmZLFdL5p17fa9U846DR28eHJNfu/dbJyesvdnHP9zFR3x4TGt
	nsdMbw==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5kfks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 08:06:04 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81cb01c07b2so9814887b3.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 01:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783670764; cv=none;
        d=google.com; s=arc-20260327;
        b=GgBXO4qqfrTBkd4mvFPOyAbzBP2JW5ihw6J+ajJ1msBl6qv4fnt9gMVq3cMyfpOpjz
         39vweBfVSQd4eUreFzVKYNdtGGk6yAGjKcDnUiRGzLr+0bisnMTwdRxehA0t66jBkSDZ
         y/KiWjjSqad6jkCXvbbRR+QB2YVfceuLlhgMQ68tMcqbg0M5yd6XKgT2OlWlE362RBMG
         rW3Q9lDPQ0uMjqmIObTMKltGISAIdcNcxnEwyUknUmro+pjwmgQ+LDUt6MYidbWFx/Al
         8pGqCeKKSo9hGPkRKUv0oiGHt78v2NfttjerzU65eXpK0FssQ+lwmYAQ6+dt6E9ZWc21
         NH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rYdv04oG7QSSqQZeIDnFcGqjfR8SCbXpzGryBIgOyyw=;
        fh=0Uh6Fxl1KfLfx43OgCOmYJBrXObkx64+0Ge4iFhg8Co=;
        b=W2A7/bHcWkHfYjS9fh28OvhHmlKIaqfa6pqW50Os2RIThCf4SeMhG3jxp4LQqc32hm
         Qk6B2N70ToCS+ZFpRutk3ngTkKZMw/x2ALrP2U8liiZ7eHCbHy/Jnud+KTffAa1bPBDL
         6VNy/iKxgVHtSzKy5MNLJVN/nixO1t5rBcHs3V/D7EmcsDfl6UMC4nwmsM5JCYEUOu3P
         CCH9hTZJkVeeXoSr9nkzaB73NRgsAwuDXliNDGz6OLn+W5k4P9iaQueK9Y/gKQPs/xMu
         33zVlKhup1G+MlVDfm7NC9ZyGLOtBUYRN2oZVMr3iNXsZ8kpqaHSKLfy9KQSuIp7tAmU
         CV/Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783670764; x=1784275564; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rYdv04oG7QSSqQZeIDnFcGqjfR8SCbXpzGryBIgOyyw=;
        b=IxTmFvia0qhSQRP3BiFWGJH4HASobp1OUdbe1o2TFJDLd2n1G3Qrl7PdOuXBWWwcmk
         bsbdHqOkXve0C3gfcN+cTvcGCRc2m8OES8o374dpGIDK/rwKZHEROlv8AkEG5cyAqmJ3
         BSVL+aL7DjtqBGIJelOz0CZXriXz33XvAXav3E7XmR/UTK1DIV9jox2AZ/VCGB6IMk5a
         sT/IG6lqywcAQZVrLht2yoWWkOoqhIFlFpZ2fe950cUH74UYu51P1vZ4AKJd7ND7H312
         ogw1v2brywu5vAbCbiMcwCgHowubyHt3hb1Pv4QWMqX4Iwi6ADEveEdeP4uER+mXnGQu
         o8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670764; x=1784275564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rYdv04oG7QSSqQZeIDnFcGqjfR8SCbXpzGryBIgOyyw=;
        b=bfWAwSPckuqb+LGVJE3qjrQkJO6Pp7SrO2jOb/GSeK+OLJLB2ZpsLxNvGosqOS5uwh
         C8uWNwhuAqEgqKVjYstJD6b6t/qGLD29V8trtQfunONw4oVHScvIBQp5jm8UsGynWCVc
         n4XziuMZKdbmxUMUIsSBT2RJ1AtO1fKYNMVUllqAdxEWy3URUhQOo8xu83lJqLASkU1/
         fSf9dPXNGqd2HvRiHPBUXwQaJ44bSIM8Q0/af3mAw/12FPO1jpNdfQEXVqM0WCtqkb7l
         Ln7SjtmegvEuYwy48ALhfi9wsbrqJ/wG8dC4a+mxSxV1Flj6YC7NrI1gLwbe9kU2RQ3/
         caQA==
X-Forwarded-Encrypted: i=1; AHgh+RpLva51QuQat4ko7Hr6jDAKSCSc66RTF899+PY+nrUu7/PEBbLw23MMFq5TmuJLoU12jmdqL1gZa16Na1imtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkupnUGIujTr+ywjQ+hUO9m46285+iLhFAXAuXqyd8Qb+dFwYz
	IGYXi+O6rRon0U/4YMK2n3rLtzPBHa9PbgksjwXgdIaSSYUmgD1w7eJ0CTLrVtVxppUvwLJV3Yd
	BEgi1KJxACCo73h+W1dvUnTrCra8uUM7NB4WI/q1Imu3vWSG7G4YHEPQkphcoLJi+RP9OL/YXHA
	SZ867RTtKyKg4nP4t94rLA1UekhFWg3TJvv/xE2hBJ/7Zt
X-Gm-Gg: AfdE7clzPENedXscvDwfG5fcwmnWLFa5jQciGY7CEoE4J0C4Ne3bqdIeb4ma5az2OSD
	Lv/FjKUnIH1EwIcubYaEGgtUc6ATn3wu1WPY69piMWDCyDxBAVbr4wegYdVD+/QQt4+YZkxU6k7
	iPpnBNeNu0iVnAUzqu2RNHi4ifJ5Rd/3t0n0P/mhq5L3P+jegodP6zdPXO1+Pcx7ZHqw==
X-Received: by 2002:a05:690c:7:b0:81d:5b4c:f8ba with SMTP id 00721157ae682-81dc11f3df5mr81106757b3.61.1783670763740;
        Fri, 10 Jul 2026 01:06:03 -0700 (PDT)
X-Received: by 2002:a05:690c:7:b0:81d:5b4c:f8ba with SMTP id
 00721157ae682-81dc11f3df5mr81106587b3.61.1783670763343; Fri, 10 Jul 2026
 01:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260701091226.7SWW4TrT@linutronix.de> <CAC_iWj+xDErhPeKGtsLK=nvPB7P8cQE3g9XCkaWf-d_j85FxCQ@mail.gmail.com>
 <20260710073147.XJAJbIwc@linutronix.de> <CAC_iWjLO3CAAFXE3s15Xcy3pWFK3ge5sWYmHHRBtcccKM2e1hw@mail.gmail.com>
In-Reply-To: <CAC_iWjLO3CAAFXE3s15Xcy3pWFK3ge5sWYmHHRBtcccKM2e1hw@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 10:05:52 +0200
X-Gm-Features: AUfX_mwICOJc44DowSC3LE5i066PLHBu7IpKzk3cTcYCH17D6Iz-aAH1CV8bv30
Message-ID: <CAGgiveXyOGFY=gyn3ok0p7wtjP_1oY6Q9Jqa6fCYXrwRoNQ=tg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Extend the real-time hardware bits with
 some firmware bits
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "jenswi@kernel.org" <jenswi@kernel.org>,
        linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Clark Williams <clrkwllms@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a50a7ec cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8 a=UXIAUNObAAAA:8 a=7CQSdrXTAAAA:8
 a=KKAkSRfTAAAA:8 a=bCoxK1dQaO2rIu0SeVsA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22 a=a1s67YnXd6TbAZZNj1wK:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA3NyBTYWx0ZWRfX48zY+H1FyqWJ
 py2P53BvuPbejJtMizP/Sxy5oy/WOtKuMkEHWspzPj45j8YD/fC6kOksRWFwzMNXIfZHNdEMQs/
 k72mU5qpKc8YofxdZU5Hl9PYAZZNuC8=
X-Proofpoint-ORIG-GUID: mrOuKtjZDtU_p2BDT1zi8_6uoMfaCpf1
X-Proofpoint-GUID: mrOuKtjZDtU_p2BDT1zi8_6uoMfaCpf1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA3NyBTYWx0ZWRfXwwCi/JYOjFo2
 LJDcQzBTgCMwYkOKncSf9iaL6nO2tE2iPvDLdq+B9p99doSGMJ9QcRmNFkxLkU13YofU6kTqAzv
 NyiN32fReOhaMP8D+WJVYtxJ6Q5OSKK6bf0Gew76z+YZk1Bm92RyqRt1cSmE/6dDzEdTfIpxM7l
 DVIQY6cW7uTyrDJHuy2UgMVQXnItiFus003GZxwdaXW3P4OopUzlHv2Y4BvE3FwRAbKVke+FQfp
 /dHksVvpFTd84wmUY01q9HEPJLksANNY0qPOEPexSWh0AHnZBSweUkRzMK8lkR7QcMjl3F965hv
 gVZ6hMam4QVvWbS6osqCa+x/0UtmJITBQGpmW3sff4tKojFTMbx6NYcAhyCPj80oOoA+5WIJZ4/
 fKXTox0Y61r27nfDAuc3vX4jKryzYAybg8n6XnLZLzgSwnDp1x/HgMizuaCZ6tQZNnWkKYDq8Ho
 fjpJWP2fTjKiXLMXWkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1011 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100077

Hi,

On Fri, Jul 10, 2026 at 9:53=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 10 Jul 2026 at 10:31, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2026-07-10 09:29:55 [+0300], Ilias Apalodimas wrote:
> > > Hi Sebastian!
> > Hi Ilias,
> >
> > > > +++ b/Documentation/core-api/real-time/hardware.rst
> > > > @@ -130,3 +130,95 @@ https://github.com/Linutronix/RTC-Testbench.
> > >
> > > [...]
> > >
> > > > +
> > > > +OP-TEE (ARM)
> > > > +~~~~~~~~~~~~
> > >
> > > That's RISC-V as well nowadays
> >
> > I did not find much here. Their architecture isn't the same as on ARM i=
s
> > it? But the overall concept is the same, right?
>
> I haven't checked the IRQ vectors on risc-v, but I assume they have a
> similar logic since that's an OP-TEE design decision not a per
> architecture one.
>
> >
> > > > +
> > > > +OP=E2=80=91TEE uses a global serialization mechanism (the "big loc=
k"), ensuring that on
> > > > +each core only one OP=E2=80=91TEE thread executes secure=E2=80=91w=
orld code at a time.
> > > > +
> > > > +Execution flows from the normal world (Linux) into the secure worl=
d (OP=E2=80=91TEE)
> > > > +through the secure monitor at EL3. Linux and OP=E2=80=91TEE cannot=
 disable or mask each
> > > > +other=E2=80=99s interrupts because both run at EL1 in different se=
curity states.
> > >
> > > That's not always true. It depends on a combination of OP-TEE and TF-=
A
> > > configs iirc.
> > > The most common though is that IRQs and FIQs are directly delivered t=
o
> > > S-EL1, in which case OP-TEE can mask IRQs.
> > > There's also a difference between GICv2 and GICv3 in the way
> > > interrupts are delivered.
> >
> > You are saying that OP-TEE can mask Linux' interrupts or if OP-TEE
> > instructs TF-A to do so (via config)?
>
> OP-TEE can mask Linux IRQs

You can find more about interrupts in OP-TEE here
https://optee.readthedocs.io/en/latest/architecture/core.html#interrupt-han=
dling

>
> >
> > > > +
> > > > +Architecturally, the secure monitor can mask or reroute normal=E2=
=80=91world interrupts
> > > > +before entering the secure world. In a correct OP=E2=80=91TEE/ TF=
=E2=80=91A implementation, it
> > > > +does not do this for the duration of secure calls. Normal=E2=80=91=
world interrupts
> > > > +remain deliverable, and a normal=E2=80=91world IRQ will preempt OP=
=E2=80=91TEE via EL3 and
> > > > +return control to Linux.
> > >
> > > The 'sane' case is indeed where IRQs are delivered to OP-TEE which
> > > exits back to Linux immediately.
> > >
> > > > +
> > > > +Secure=E2=80=91world interrupts (FIQs) are possible if the SoC rou=
tes a device's
> > > > +interrupt as secure. Such a secure FIQ will preempt Linux immediat=
ely, trap
> > > > +into EL3, and transfer control to OP=E2=80=91TEE's secure interrup=
t handler. Linux
> > > > +cannot mask or preempt this. Secure FIQ handlers must therefore be=
 extremely
> > > > +short to avoid introducing noticeable latency.
> > >
> > > There are also 'fast SMCs', which run with IRQs disabled for their
> > > entire duration.
> >
> > can their be distinguished somehow from normal SMC invocations or is
> > just a consequence that the secure monitor does not enable interrupts
> > during transition for some of the "functions"?
>
> They can be identified. There's a function identifier defined in the
> SMC calling conventions doc [0].
> Bit 31 is always 1 for fast calls and 0 for yielding.

This is a calling convention and is not controlled by hardware. There
are exceptions for the FF-A SMCs, for instance.

Cheers,
Jens

>
> >
> > > > +
> > > > +The transition from normal world -> secure monitor -> OP=E2=80=91T=
EE and back introduces
> > > > +additional latency due to world switching and context save/ restor=
e. This
> > > > +overhead is typically a few microseconds and usually remains in th=
e noise
> > > > +floor.
> > >
> > > That's correct.
> > >
> > > > +
> > > > +If the secure monitor masks normal=E2=80=91world interrupts during=
 OP=E2=80=91TEE invocations,
> > > > +or if OP=E2=80=91TEE uses long=E2=80=91running secure FIQ handlers=
, then OP=E2=80=91TEE can introduce
> > > > +measurable latency spikes.
> > > > --
> > > > 2.53.0
> > > >
> > >
> > > Overall I think this is worth documenting, but infortunately there's =
a
> > > wider range of configs and corner cases we have to describe.
> >
> > Okay.
>
> [0] https://developer.arm.com/documentation/den0028/h/?lang=3Den
>
> Cheers
> /Ilias
> >
> > > Cheers
> > > /Ilias
> >
> > Sebastian

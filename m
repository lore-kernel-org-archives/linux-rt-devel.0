Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F6381B0A
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262426; cv=pass; b=S5OCaJ/KFzOuaIlSTWtBb56BNkztbA5zkaShb1Zbv9YhAtcnXTM6ofCPhq6H9oUAGdt6iwohPA5FN2yjO6MRrXnjprIIpCawwRcIqUGWrUBbDPtj3DQpQG9GTEltnwka9lche2L7rglWlDZfZSKMSe5UbaYCxTu69xUaR103bBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262426; c=relaxed/simple;
	bh=wqW3HWAbcn6wnvgBF5x69NdHeVoAaMWxdEowLgFtGl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtkfx6qblwxNL3xUHUd7mvCWxxdbVUMtN9gDk0U63CDLcYgc96j9MZMH7Efq1+DfGkkhGx5E5ZqvaSfZK12X5sWGGOhG7W1PzRIVkIVGtfxUQieJIrZLCFhSweY31XrLs0oJmo5miQwCROpxeIXdQk77QnbC9Aqcwv1x2+Fn6PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CH7B/SyV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UosUqKi5; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CH7B/SyV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UosUqKi5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJJFk1136750
	for <linux-rt-devel@lists.linux.dev>; Tue, 1 Sep 2026 11:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V6JiqLVIKwcrWqWIh9PGanD5SoJcpxSHH3ZfyxSSvuk=; b=CH7B/SyVwOMv/qdY
	AGJIJE05vndzFXl4sW0cx3haeqXZKbeYHjbF51huewfiqApyC1Uy//LuQt24yHzx
	FHs9InwipUZqpds17mkVmuer3WVsQw85cHUJd0QRq81ROTnSKYLsjuDs3gK3J0NL
	lnYtO2PsCX1BN70fgcWoonzYaJWzQw6IkJDPa6EkJGtFd4gNa5DO3x2xJ0SzIu/L
	3xe8faebpbZuImf89hhXBU93NppsJCNK115z3GUijqyb/fLWsv6L8sJqBAyX2Wci
	eR2b5+Xhr72QRxLq412tqGH9EPYHSXAKHf+JeW/xDwDq2h1T5T9ffkltopZk+FNN
	R5ZigA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdrcshkhr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Tue, 01 Sep 2026 11:33:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cf1c86963bso9674575ad.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 01 Sep 2026 04:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788262423; cv=none;
        d=google.com; s=arc-20260327;
        b=JNXEtryRHKN+5RQgUcJICaIbNFOUqQ5O3yoSvG0I7+eC3Xkwt+A/M0Jl0POpPjT/ey
         UslBFAORmbtBVB3qacXVTFcYvs5+iYBkhfbVHAX6pMUe0vrZH4M5sjqwdPVdJL1uLpKd
         utEMi5/a2M/dRDS6iHTeFgi+DGynL9g8xHwlWdYOH4JOr8eOfIZVtSgaPKnbPg4rFz1I
         kWW3Ke9bA0TfzNX1RAIGRwncdm+VMQIdPHNnztIYuyU4ZbIj3HUrR30J880amEjBdvoA
         ena53e1UeVzd/HP8ycuLzDFywH+hF87oB0i8o4hHIKhXA8fRORNk7DjZzcpnoFgyUqO1
         t8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V6JiqLVIKwcrWqWIh9PGanD5SoJcpxSHH3ZfyxSSvuk=;
        fh=Ekc84Cnpq0hx7iBPE9VaYaLATTr/UkUkhP6dBUjfMu4=;
        b=rJvjZNn4Zc2RpZni4G7TOOXnY0C3ptfPXduqCtfc3HXVL1ybeISDJbtwP46Jj9CaIq
         /5LPFdRbDnd0AkdfptP42y5ymyU4dBMQ2Z8AnmvrMEG3293yKaXDhPyyxVHkHhlCcKtr
         qbG25e74RK7zIjj5m+hCa81oVkMeG3U5sFvsMV0ooq1JrVeubpml0PCi25MyM7EvhRhG
         wgZop7M54UQ0syjnWJEwE8eQNplzRufxKzb/ckoU4hq2aQEZegwk19hMiHH56jLwsC9F
         qITt5dwkuWTRUKPMk6WIRVK6HKNSRiGiShHXz+UdO6i4kTaJZ2E+nhGhJ5ojspiXVEAJ
         LC6w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788262423; x=1788867223; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V6JiqLVIKwcrWqWIh9PGanD5SoJcpxSHH3ZfyxSSvuk=;
        b=UosUqKi5SJDU7vT2wlIc4yRiEHEHVBE5iT0cRucjHo7K38k9vmvTn01gvFLv8477Ls
         /kgbTV+cZsFfMTVWQ5xGIjdE22jPto8s1hzo9U5zjJ8GF0GOMHndaBH+WRfej4sMp8NB
         AX/9mvjArwqEzzEB7tXCOQOq/blf8tHZKTUVc5bmNkPDNJX0bOiq5oRHsVzkN1h6HnxC
         JUOJxBsPQFOOL2kpQ70m/1maYyB/RFD+Ooqp/SDCIzsvX/6R0ASwy2HgyV4TTap9u7r9
         XDWC2u9wLhsjBxBVhEN9TwKYCsz6Uoev3OI1WhN65E4YssL0xIBtqJ5DlZaqT4MzriMz
         poPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788262423; x=1788867223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6JiqLVIKwcrWqWIh9PGanD5SoJcpxSHH3ZfyxSSvuk=;
        b=py+EdDl/Trafgb8HyChRWQ7oNLlxqRqtC+jk2n6Z8PJovobzkrWTs7GrAcduiLTEjY
         4ptcyzY/SbvJqnbvkbkjsGzCrI9iqIh6RQCQnvePg2iOLLCWPKeYGTGtmRaJC2jTdTUh
         bCMBgd1rmtqZFPp0wIzjpTu0jCVm1ex/36KqgqprenA6OmpAC1kvxPq4HcLbTN5ygh1j
         FkN5wjSKsc9wIQw1vfKFa2ZfsR6wcMcgFJcL5sTYI+q/Z5DgWXPyUY5xI0tLudwQB7Hj
         uMG8IxFhlkN/KPjpcSo0TZfIFuBXxGZx0S02UHTQVIGnAQUiFkrQxB8aD78XcTCRQKjC
         59yA==
X-Forwarded-Encrypted: i=1; AKwUvBxaJPBuxZNv+dHcz1tneNni9Y5zd0X//H3WjUY4oeGIogNP+iV9w7xUagTMWcMyKNEN+VTwoy34OqDvuc9jww==@lists.linux.dev
X-Gm-Message-State: AFuF++kTRpRiETGyHUa8ko7dwtqlId6fhTAIFUXZ63nLl7xnJ0XZNNOY
	3sjh9Twzs0mK2eNiKDe7GiLdeZb5cX0BBIS9SVmVJoREooAPvAqx8RzRpp4oxnzpCqws+QdKk3e
	yx7cnnWzmAk3D7uMg5YlUN3zANz7oJdhl5WlGF2fKTMJwheV1mxm0nPgdppbHhrXNvVKsjII7uY
	adt5Q43ItC6tMeEwis7so/EgkRnZa4MIERR1wZDzei9QYlN3WD32sA
X-Gm-Gg: AYBFou0Qr5qBXI8j4JNKjE6mYNHkbaEVlJKuOf5sbBugLWKuoksTIFjAGpDHY3MVW3T
	FeIYeOnoh8VKP6r9xXzEQj5WO3Uw2lQky7cqG2yfVatreNGYz86YoWwYvL59LjykC+4pUTsU+FR
	k4rI6BNt0e/33XtW5awM2sT9sWdXF58yP5GhloFJTK9ZBi41bnoSKaBG+EzA==
X-Received: by 2002:a17:902:d2c4:b0:2d8:d4d2:d135 with SMTP id d9443c01a7336-2d952845317mr45504625ad.17.1788262423299;
        Tue, 01 Sep 2026 04:33:43 -0700 (PDT)
X-Received: by 2002:a17:902:d2c4:b0:2d8:d4d2:d135 with SMTP id
 d9443c01a7336-2d952845317mr45504165ad.17.1788262422831; Tue, 01 Sep 2026
 04:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260831-topic-lpm-psci-domain-callbacks-v1-1-4a47d95c9c79@baylibre.com>
In-Reply-To: <20260831-topic-lpm-psci-domain-callbacks-v1-1-4a47d95c9c79@baylibre.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 13:33:31 +0200
X-Gm-Features: AcwNN1VtZoA1_YSarl9l5fAeELnFtcgDxJxCO3oJ3BzWm6vuhhyYMYT4SOZL0-0
Message-ID: <CAPx+jO85NBZq=YCxhs5Fbo5rDZ7pGHHKiG2HRJUNVKj_1SOscg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Assign domain callbacks to all CPU idle states
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Scaria Kochidanadu <s-kochidanadu@ti.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEwMiBTYWx0ZWRfXxMOH+tPcgDr6
 /TOy8MaWppjSG5afY0Cc4x++PdEMaI38ImEVh7lJ4/AMMSFRZiGqJ9eivtaI5m8z7GrFW9ScQiq
 cJHiTyk9c62Hs1WKrE14src4RmE5SuY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEwMiBTYWx0ZWRfX2VMHYH4GAjyI
 gzdMCR5ZREm4TpaRI1aYLbqny5voTMhm/Rkf2EqktjJQsrt1BH+couPOZWNQGQaOHzTRq3NjtAn
 c3Pb4oU0yrCo6T2Btq8v2XmKML8yHdwvsiy8n6TFtulPmVl+QcSnzykFkji3blCSb/wCrNfIMZk
 d6fIoIk6EFCXHXCEQlxqa//AjgBwXJqweth7Bf3xkWVx9hxNb5Dalv7UZQHCFj1xjlZ/R67sEWW
 sjCLDWQ2xCc2Vp3hAVGEDm5OfWsiI6Eb9nhanrml0ZrKGbWaNIi+wWaT6BuzWqb9Iuwi4cKtqoo
 FPRK988nbh6vXVhxVkBNna78C9duCUKYmuDj4MXxjxE1ouyV83DDpP7sRXzYIJVgZC/g4Suu0M5
 gm2eXRgZdYOgYa5m8aTeO3KGbGomgB4f8gTktIAP7l/TXAd/szqbbCUSvM0qMnX6tVNJaZm4FOh
 8yzebWVnMSw2VRZEVwg==
X-Proofpoint-GUID: OciiMzlGUVCXOnHNHxUMX2h-HEpeahNK
X-Proofpoint-ORIG-GUID: OciiMzlGUVCXOnHNHxUMX2h-HEpeahNK
X-Authority-Analysis: v=2.4 cv=QsNuG1yd c=1 sm=1 tr=0 ts=6a96b818 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8
 a=nffbhwOHn8sc9RhtvssA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010102

On Mon, Aug 31, 2026 at 8:52=E2=80=AFPM Kevin Hilman (TI) <khilman@baylibre=
.com> wrote:
>
> Previously, only the deepest CPU idle state had its enter and
> enter_s2idle callbacks set to the domain-aware implementations. This
> meant that if a QoS latency constraint excluded the deepest state during
> s2idle, find_deepest_state() would find no state with enter_s2idle set
> and skip the domain idle path entirely. Similarly, during normal runtime
> idle, shallower CPU idle states could not trigger cluster-level domain
> idle states.
>
> Assign both enter_s2idle and enter (non-PREEMPT_RT) to all non-WFI CPU
> idle states so that the domain-idle-state logic is triggered regardless
> of which CPU idle state is selected. The genpd governor remains
> responsible for honouring domain-level latency constraints independently.
>
> The enter_s2idle path uses dev_pm_genpd_suspend() which is safe on
> PREEMPT_RT. The enter path uses pm_runtime_put_sync_suspend() which may
> sleep and is therefore still excluded on PREEMPT_RT.
>
> Suggested-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psc=
i.c
> index dcf20ea5ef5e..db9aa57c51f5 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -250,6 +250,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_d=
river *drv,
>                                      struct psci_cpuidle_data *data,
>                                      unsigned int state_count, int cpu)
>  {
> +       int i;
> +
>         /* Currently limit the hierarchical topology to be used in OSI mo=
de. */
>         if (!psci_has_osi_support())
>                 return 0;
> @@ -261,14 +263,22 @@ static int psci_dt_cpu_init_topology(struct cpuidle=
_driver *drv,
>         psci_cpuidle_use_syscore =3D true;
>
>         /*
> -        * Using the deepest state for the CPU to trigger a potential sel=
ection
> -        * of a shared state for the domain, assumes the domain states ar=
e all
> -        * deeper states. On PREEMPT_RT the hierarchical topology is limi=
ted to
> -        * s2ram and s2idle.
> +        * Assign the domain-aware callbacks to all CPU idle states so th=
at the
> +        * domain-idle-state logic is triggered regardless of which CPU i=
dle
> +        * state is selected.
> +        *
> +        * For s2idle, enter_s2idle uses dev_pm_genpd_suspend() which is =
safe
> +        * on PREEMPT_RT. find_deepest_state() will pick the deepest stat=
e
> +        * whose exit latency fits within the active QoS constraint.
> +        *
> +        * For the normal idle path, enter uses pm_runtime_put_sync_suspe=
nd()
> +        * which may sleep and is therefore not used on PREEMPT_RT.
>          */
> -       drv->states[state_count - 1].enter_s2idle =3D psci_enter_s2idle_d=
omain_idle_state;
> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -               drv->states[state_count - 1].enter =3D psci_enter_domain_=
idle_state;
> +       for (i =3D 1; i < state_count; i++) {
> +               drv->states[i].enter_s2idle =3D psci_enter_s2idle_domain_=
idle_state;
> +               if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       drv->states[i].enter =3D psci_enter_domain_idle_s=
tate;
> +       }

This breaks the current contract for genpd when it tries to select a
domain idle state for a group of CPUs that shares the same PM domain.

In principle, if the CPU has a clock gating state (shallow) and a
power collapse state (deep), it would be sufficient for the CPU to be
in the clock gating state, while allowing the cluster PM domain
(through genpd) to enter a domain idle state that corresponds to a
power collapse state. Depending on the platform of course.

On the platform you are working, is there a clock gating state (or
similar) on the cluster PM domain, which is allowed to be entered when
the corresponding CPUs are in the similar state?

>
>         return 0;
>  }
>
> ---
> base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
> change-id: 20260831-topic-lpm-psci-domain-callbacks-a8af0cd7df35
>
> Best regards,
> --
> Kevin Hilman (TI) <khilman@baylibre.com>
>

Kind regards
Uffe

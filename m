Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC3495057
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Sep 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437013; cv=pass; b=LQQ202aI3sQqoHMml+maHjUJg3XS3TKTmxLQ2eA51Lg+qx+mp2IfwedmIJiiin6a5paHwUdBlAZCl8GLB8DaJezsJaPvNEmKf1+H2o9DCskTVl+bbRK+S6Z+pEXdaVOVSXmJwpUIRdXIpqGkh8xckAI347rc/cm3Laye9bDBk+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437013; c=relaxed/simple;
	bh=6j7t0PuYSLHO5ttUmiv0eJYJmVPLsVoYh7/R/hbBR4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qstcke6jm2WI8B5f71wf3ya2ffR9a8oBBCkm/Pb683ZnYFeDzhzxNKmda6CUWh+/BQ8wPZENj4/ilpFOx9l4aHorzumk8idFPE8UpxLvqV/L81lrEuhI60eq0PltoebMyp79X8/50YpCVwqVUB8FKyFFctTHksZG7DaBY6+/UbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/u5A7qE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S/V96/gb; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/u5A7qE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S/V96/gb"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AH5YB3720252
	for <linux-rt-devel@lists.linux.dev>; Thu, 3 Sep 2026 12:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DSbHTsqtVhnjQL48exVAucFN4ABmL2gOFoCQ684rxK4=; b=F/u5A7qEMzrjO8Pm
	yqHSeta7duGyz4XIev213chNKedcWNup8cLcDEkMPrc/rCF2poXhpjkjGkRde8YF
	H92Jefhd7xm5YDzxQxLf6oQPFuc0GUZPmVa9QurfqpyODGVMhaJh4yfnOM17EUAa
	kfKmRaf51eI2qsaO7kaNQ6giMyfhU45PZTu8R8OyS6oKBpqSTx6oWKH9j8KXr97B
	puz26z3poI9mk6nCH/cIBuN8Dkcf0vqgBG5Zj+dKW4+S3zQhWG801vUXQRjfqnm4
	G256uMqfHuGUVnxGpucCOfJimFHfr4HZmlOIl8ml+x+aPXBFuJS6+qRuvZEezql/
	21vrwA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf0gjsyym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 03 Sep 2026 12:03:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca8aee88725so3434733a12.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 03 Sep 2026 05:03:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788437010; cv=none;
        d=google.com; s=arc-20260327;
        b=g7L1ymNFZkkijNUZdQStdLIERUJnKe2XrjMFpaV4OP+j3Xg874ljufh5HeWQehAZmI
         uS2H7n4pJYDCp/5HGmBE1QOc3f/cO5uwJyn26sR6SNjfI3DmjCDRnff8gIAIL5bZLppi
         A+PRCKQnH95amecVlwADH6wlimUWh5VAGVpkICHOoz1yTHfUdKbd7AhF9vfxQ92LIlg2
         /rdMXPcS5REAsbXq6Z+79wG6QGgHkVrrmKC21atM30ZT4X5IQbgO3f71yb+EDUePYHFQ
         oPOkdxZM4pgnQv+L6OM9G7NGbbnJBF1frkClp33zhZT7vGo41u9vjKUuNiNQ5D0Gc4/0
         wgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DSbHTsqtVhnjQL48exVAucFN4ABmL2gOFoCQ684rxK4=;
        fh=2/cLVbh2VzOxhsKES43oyDuHvPFmAq8RHuCMyT0wm4M=;
        b=btqY985c0hmG6gdD5uWdMQZS3NoLrGpPT+Xcrd44S2F8JDRlxrfrfFT87i/LfP2KPg
         0wWjJi12jf4p31hi06/FzPl7tnYhKoSU6MTkqdBJZkJ022uauxktwyCXzaJfnVH1GWTV
         i6R/lv/O/Dw1RqVLIWK4u4cFaUHapGUk8fdLmdqNV2cGPv99tfRsGfqa5cuaVkgfpbU4
         zucOccrfLKDEqq9iSM1Nrvbfpkrv6+R36dbPVUB4FXuuQn0Siouz6yrCEDUi8n90/IS9
         9IMQDb/m3dTBOYek5MlJAofiChpLxSJ6K2oGcd6p4SK/Gei0P2o5d6SXyzqUeyBQ8J0c
         LYzw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788437010; x=1789041810; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DSbHTsqtVhnjQL48exVAucFN4ABmL2gOFoCQ684rxK4=;
        b=S/V96/gbLh9CUXgyCvkzNSZ+0I1icdY0ZwqvbIUANjKBEbzh3ND/KETyEJJla96Xcf
         a3fDzPs2SpT+jCD99yeWz2JQfmsXRE9Tv5AdUEtv5eVIH7qJ6lrxBES4Y4YQ46AQ47KN
         3AoUiorHQvumMbbZrlpE+bN+4Fcv1fX/B/URWFm3PkAWgbmJzi/0xJ/9vqjZ3i1ZbGvk
         vDTl/Qo4k1A9uU0XrLtdjh/aIPmU6y5XY3ZmsnBH3O3KsPOfvBpTxvyv6nZ6QDgkWAxa
         fA8xYkZYxeDskM7u01yxQUTFVjWXpKEm741mK5EsORgfhx+aa14ZtOTlzQs7TX+ITWXV
         tKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437010; x=1789041810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSbHTsqtVhnjQL48exVAucFN4ABmL2gOFoCQ684rxK4=;
        b=Ci4jB2HHFbFn3xr+XxiUDzOaTd080yXUGhEA4goVZzAQyDsIoTllq83fwyMbg+Us+b
         lvGPzzVm+89Fxd086UT8vDTWUvzHTTHiuGdXKdblxqU0hhd7uCT/tP9yl6TEsUyN8uiq
         2FdkON90VCQz4TCxCvXRC47VU/fYqsWoFBXqnBFBD9p9MRRNzvBwhLj3kFDGSiTLJagu
         /yOZJiVJ8xQ+hA73gFzsLJVG7oh705183cekqyqKaTJph2tYjK1SdjOyfCu573nSQlSx
         iIaplPx1nGi8RR5ypoyb5jKDgtCTdIGM/pD9Ba5BLAM5OK+RagKH4BplJtExsHU8N4qS
         kg1A==
X-Forwarded-Encrypted: i=1; AKwUvBxqcEKHXxu/gAcNk3e3bDF6iwVUmxesZmR0VMhh7DynVJXv1EpFKF3YNs2iaxtdD873l2nEpShEu5oAZc5rfg==@lists.linux.dev
X-Gm-Message-State: AFuF++nIYUXLOvJK9Wvr9TNMXd385IEN1Fv0Te2uRD6i5x1f4RT0nnTL
	52Q2y1QnIRHaASVVr+uxOaWE2hDVxmFVMrOuRlSpJyqHazIhpc9RMJ1kGVitADZ9Gxc0hZRDExD
	8OgKbQRpknv63fOOeMFTcpFZkUWl0rOUqv1SnjsUgEaBDzWmkpfrqEOW2IDTEE0RZZqVVBccCI1
	SS5DfZpSEz5YbKVGpY2kCyoogdLTmktTjlbNwIXuU+pbTA
X-Gm-Gg: AYBFou1JtoZKpwjh573d5i+n6YC994RXjYksA/Ozyqa3J4oAE6R/KQavbBtPVM/W7UM
	YU3DDDtGD8ciFyvr5l51pTtCwSzaDvQD+8jrzVl4XOLUT8JFN05nc08iWXJaJIcTjbNw006dAFO
	aAA6/LEvQr/Pz39xJl0lLmA2z93urHVHM4++K2Y4v8fjwQmSRGgYfVR7Vy8w==
X-Received: by 2002:a05:6a00:301e:b0:857:72ba:ff10 with SMTP id d2e1a72fcca58-85ed4c1b522mr17374507b3a.24.1788437009794;
        Thu, 03 Sep 2026 05:03:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:301e:b0:857:72ba:ff10 with SMTP id
 d2e1a72fcca58-85ed4c1b522mr17373446b3a.24.1788437006071; Thu, 03 Sep 2026
 05:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260831-topic-lpm-psci-domain-callbacks-v1-1-4a47d95c9c79@baylibre.com>
 <CAPx+jO85NBZq=YCxhs5Fbo5rDZ7pGHHKiG2HRJUNVKj_1SOscg@mail.gmail.com> <7hh5k87qtp.fsf@baylibre.com>
In-Reply-To: <7hh5k87qtp.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 14:03:13 +0200
X-Gm-Features: AcwNN1Uq2Tdx3qawT7JRaungyUzupVuVJdcdX7A1icKcnMlw43ki1_-ZoYUerHM
Message-ID: <CAPx+jO8k6MNSdhmj5v4ceYr8XhgHk133LweJvRpN=kF0rHF7PQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Assign domain callbacks to all CPU idle states
To: Kevin Hilman <khilman@baylibre.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Scaria Kochidanadu <s-kochidanadu@ti.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwNCBTYWx0ZWRfX9/xvmjtf6ORm
 T7T5tO52wuZWUNSZmwJy1FeWiMl0RGB/bMgG9nImZznMmBCq0UYqxd4aA+8e3FFMmXec/rcODeH
 g7xWPFyO07rvcPdP491opU076OZPSg7KSPxWk+ZPoK5880ovTDj0qCghyecT8xdPCWzXCD+l7W6
 27uTe3YtoReaTJATn48AAP9odnJX0mYD8dWtGdCffCgYIXao0LOWY8tnTtSnyyRTcLaQ3DFOI8m
 dUBb6XUF0kibloTiDQBc+dvg5/XLuUqeov16qvBNYIoVVGRVSDbaKo2gfgalBCDLRFhh1ZEJ7WA
 FhOiZz5aDF5v5ZXMy96p0s9Okg972A7V+x2Eammkf5tOQAtZQ2EAVK5wpTyugB8O4Q2kNsm0DCF
 YjynjGzzIEi6s+n9QkGIgfghRM1SQn5+JVzaP5DbBhO53AEyS+BjGHqkuL4BurgQ/bcROuQ9uT9
 VNnpZP2MmNteOpYXyEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwNCBTYWx0ZWRfX/SaWFaQRBOKa
 yd7MRvI2DGFNq+Kl4v9/zQWX5CtYXDLRoCRoNMiwwXAhlUQlrpJFBR4UqWTT86MhfW4L6jKvBs1
 gmZCI7aRnV8IVuWwEtEgxX1kCG2NNC4=
X-Proofpoint-GUID: 2F1md1R2JUte2eXrDiqEzt_lKcnsFsgC
X-Proofpoint-ORIG-GUID: 2F1md1R2JUte2eXrDiqEzt_lKcnsFsgC
X-Authority-Analysis: v=2.4 cv=LZ4MLDfi c=1 sm=1 tr=0 ts=6a996212 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8
 a=13slLdO5Tp32gFNFT6wA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030104

On Tue, Sep 1, 2026 at 8:46=E2=80=AFPM Kevin Hilman <khilman@baylibre.com> =
wrote:
>
> Ulf Hansson <ulf.hansson@oss.qualcomm.com> writes:
>
> > On Mon, Aug 31, 2026 at 8:52=E2=80=AFPM Kevin Hilman (TI) <khilman@bayl=
ibre.com> wrote:
> >>
> >> Previously, only the deepest CPU idle state had its enter and
> >> enter_s2idle callbacks set to the domain-aware implementations. This
> >> meant that if a QoS latency constraint excluded the deepest state duri=
ng
> >> s2idle, find_deepest_state() would find no state with enter_s2idle set
> >> and skip the domain idle path entirely. Similarly, during normal runti=
me
> >> idle, shallower CPU idle states could not trigger cluster-level domain
> >> idle states.
> >>
> >> Assign both enter_s2idle and enter (non-PREEMPT_RT) to all non-WFI CPU
> >> idle states so that the domain-idle-state logic is triggered regardles=
s
> >> of which CPU idle state is selected. The genpd governor remains
> >> responsible for honouring domain-level latency constraints independent=
ly.
> >>
> >> The enter_s2idle path uses dev_pm_genpd_suspend() which is safe on
> >> PREEMPT_RT. The enter path uses pm_runtime_put_sync_suspend() which ma=
y
> >> sleep and is therefore still excluded on PREEMPT_RT.
> >>
> >> Suggested-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
> >> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> >> ---
> >>  drivers/cpuidle/cpuidle-psci.c | 24 +++++++++++++++++-------
> >>  1 file changed, 17 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-=
psci.c
> >> index dcf20ea5ef5e..db9aa57c51f5 100644
> >> --- a/drivers/cpuidle/cpuidle-psci.c
> >> +++ b/drivers/cpuidle/cpuidle-psci.c
> >> @@ -250,6 +250,8 @@ static int psci_dt_cpu_init_topology(struct cpuidl=
e_driver *drv,
> >>                                      struct psci_cpuidle_data *data,
> >>                                      unsigned int state_count, int cpu=
)
> >>  {
> >> +       int i;
> >> +
> >>         /* Currently limit the hierarchical topology to be used in OSI=
 mode. */
> >>         if (!psci_has_osi_support())
> >>                 return 0;
> >> @@ -261,14 +263,22 @@ static int psci_dt_cpu_init_topology(struct cpui=
dle_driver *drv,
> >>         psci_cpuidle_use_syscore =3D true;
> >>
> >>         /*
> >> -        * Using the deepest state for the CPU to trigger a potential =
selection
> >> -        * of a shared state for the domain, assumes the domain states=
 are all
> >> -        * deeper states. On PREEMPT_RT the hierarchical topology is l=
imited to
> >> -        * s2ram and s2idle.
> >> +        * Assign the domain-aware callbacks to all CPU idle states so=
 that the
> >> +        * domain-idle-state logic is triggered regardless of which CP=
U idle
> >> +        * state is selected.
> >> +        *
> >> +        * For s2idle, enter_s2idle uses dev_pm_genpd_suspend() which =
is safe
> >> +        * on PREEMPT_RT. find_deepest_state() will pick the deepest s=
tate
> >> +        * whose exit latency fits within the active QoS constraint.
> >> +        *
> >> +        * For the normal idle path, enter uses pm_runtime_put_sync_su=
spend()
> >> +        * which may sleep and is therefore not used on PREEMPT_RT.
> >>          */
> >> -       drv->states[state_count - 1].enter_s2idle =3D psci_enter_s2idl=
e_domain_idle_state;
> >> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> >> -               drv->states[state_count - 1].enter =3D psci_enter_doma=
in_idle_state;
> >> +       for (i =3D 1; i < state_count; i++) {
> >> +               drv->states[i].enter_s2idle =3D psci_enter_s2idle_doma=
in_idle_state;
> >> +               if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> >> +                       drv->states[i].enter =3D psci_enter_domain_idl=
e_state;
> >> +       }
> >
> > This breaks the current contract for genpd when it tries to select a
> > domain idle state for a group of CPUs that shares the same PM domain.
>
> Could you elaborate on what that "current contract" is or point me to
> where it's described in more detail.  I understand there was a reason
> for this design choice when first implemented, but now that we have
> added support for using QoS to constrain the state selection used for
> system-wide suspend (including s2idle) this "contract" is really
> restrictive, and doesn't allow the domain idle logic to be used at all
> for shallower states.

Right, that's a limitation we decided to start with, simply because we
had no use cases back then.

So, if we would do the runtime PM reference counting when entering a
shallower state for the CPU, it would allow the genpd governor to pick
any of the domain idle states for the shared cluster PM domain. This
doesn't work as is.

The CPU PM domains are structured hierarchically and the child CPU PM
domains that contains only a single CPU, don't have any idle states
that are managed by the genpd governor. Instead those states are
presented to the regular cpuidle governor as per CPU idle states.

>
> > In principle, if the CPU has a clock gating state (shallow) and a
> > power collapse state (deep), it would be sufficient for the CPU to be
> > in the clock gating state, while allowing the cluster PM domain
> > (through genpd) to enter a domain idle state that corresponds to a
> > power collapse state. Depending on the platform of course.
>
> Yes, that is possible in principle, but with an important clarification:
>
> Once all CPUs are in an idle state (either shallow or deep), the domain
> idle state logic is entered.  It's then up to the domain (or its
> governor) to select the appropriate state(s) for the domain.  If any of
> the CPUs are in a shallow state, the domain governor should not allow a
> deep state.
>
> In your example, you mention the CPUs in a shallow state but the cluster
> domain would pick a deep state.  I would say that's a bug in the
> PM domain (or its governor) if it would allow that.
>
> The job of the PM domain is to pick the deepest state that is possible
> based on the state of the devices (including CPUs) that are in that
> domain.

Right, I see your point. So in that case, we need genpd (and its
governor) to know about these per CPU idle states, as that piece of
information is not available today.

>
> The same is true today for domains that do not have CPUs.  If you have a
> device that runtime suspended, but in a shallow state (e.g. only clock
> gated), the PM domain it is in should not hit a deep (power-off) state,
> otherwise that device will lose context and not resume properly.

I totally agree that this problem isn't limited to CPUs. Generic
devices can certainly have support for multiple low power states.

At this point, through runtime PM, we support only runtime suspend
(not counting runtime idle), which means there is only one low power
state available per device. It's only PM domains through genpd that
currently supports multiple low power states.

For a CPU device, it's slightly different though, as we have decided
to model each CPU to have its own CPU PM domain.

>
> I'm trying to enable that same thing for PM domains with CPUs.
>
> > On the platform you are working, is there a clock gating state (or
> > similar) on the cluster PM domain, which is allowed to be entered when
> > the corresponding CPUs are in the similar state?
>
> Yes.  Not only the CPUs have shallow and deep states, but the domains
> can have shallow and deep states as well.
>
> Kevin

Sounds like we have a BoF material to discuss at LPC...

Kind regards
Uffe

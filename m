Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719849EC74
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288374; cv=none; b=sY9ACNnN5w9jO0m2YIAJNphwnblfdGs7BAgHBZIHLU19Q9/THwkH9dQPR6ZDYQ3F9I9QWApaggdHqF7AMBXZS9C00ojrvJpe/p+MAHM24UUkedYq+79pHbk3ZxuWhd/CPIqHS5xT9oVrAAPrD82G+eDha/5VbRxvonWLHmrrATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288374; c=relaxed/simple;
	bh=zTWHgcVtDZxO0SC49BeTSWdCu86YpldasbFV4WERbJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OGCHHkYsjjZSzVZ8PYXFw9xbZNpFSUwHQakdJkyggmUoqaobsN8uezwlykKMMZbAwCUhlekIho96mVrlv+WKhBSxDq8ogub/b9nf0ZaCkNSSSSf53uik6Y9JBR4BcbJu5/UqwR7VWa41CeYCY42Z5WkukUu/NUbqSIWAp9EEe1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NsMKiQ97; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NsMKiQ97"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84830c774a0so218155b3a.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 01 Sep 2026 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788288371; x=1788893171; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IRSg5TsPLhCh9Up4rkAnm+9DnhJsd5XJxJ094xnRn18=;
        b=NsMKiQ97AOb69spgREynIocRqYUcIR7LfBtsZL4jGQmpqfl6KlH5DpQZLqFGTbD8GF
         DyFx3Itmziy7ikgww4o6J5DTVr4+4NoinChCCEWaXpeQUVTx8bObcveZqUU3mIMsz2ZD
         7nOmI1vV1SCwCUuRhzr3ZJ+o4IQuGzS9J34NCNRNysog2RrC73J8OPGJ3JG7YTGDOfgg
         W16lFpCLcYrd8TjiYtDfLgB75nIra0ioyt2sDRNNYFBEwIPGvyqNYJOCro+XJxKzpI9I
         PVPRNK2OAQzGhNIkFS/H9/iNHcUTcyJSgC876YVyQderXXGJgdKSa4xJlH/pE7jfqIZB
         nQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788288371; x=1788893171;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRSg5TsPLhCh9Up4rkAnm+9DnhJsd5XJxJ094xnRn18=;
        b=Adsq89L8gh7e+Nvb3U4Iu8CPboZVnQkVUZ2pGhaHSr/iIeqokn8eBji2x5YaOW3v9H
         /glA+ki2Kub3U+3EEtzmoIaFU8JYOMUcytJnO7ou1+yn2S0ydS1lxZVMeI/gUEXKS3ro
         jh2Qb2lPzvZ3EYtsg3dPask8m62qcCosh1llvAJFlYVt597mQ1l65mkrVPmxPA4397Xd
         7M5ipVNHL6CAzfn8fqVbhtexMCP4ivftUj74k0yT5rwz1oqK8duY0T1AZy2B5cV6KhSA
         g5PzVYBHDMtmMv8iCHr5srd0KvY44tZ2dyEF3NdIfGRiAhF4arYO+YdUmCG1UE8udCdl
         KjFA==
X-Forwarded-Encrypted: i=1; AHgh+RphJZ4h8IQZCAkDlxabLUKxpOjzgRYf3nuJEWTPIMqjv9qk1SL9ylMHXRa0vMwI4IUqOHbqpESkupv7m6xXIw==@lists.linux.dev
X-Gm-Message-State: AFuF++nk9fPQ8SWAZFuabn5BF0vTmvuHPHF+Ls1SB46fnOvu+bJBibpy
	H95xmNbxB6nitmMimqAS4iPlGAjsX4IZ+5FHU+B8mU+HfECRjszV4Rp5mcKFcp3UFe8=
X-Gm-Gg: AR+sD107gLFIMC3a00gsZWXtMCgBo0nn2vZ9qWeDrBtciobH7koFxAQxXeM99/8plYX
	0o8WWb/RUjNW7rO97oqWwM22cli8RhvpS17IAdmSye8LFRz/rqlkjXOzrjFaQqKuj57bf23ohrt
	kl7ojv80ZPRIPfYasr3nxDD1r5jzBG/oe6EwYM0A/bqJwwW5j/kv2pO/cv1K4XepJJ3dVUQAeLP
	y7kCOD37cBSPlc/6fruZrcGuZHc8rZfpMjOjaNEr3yCWgtUvLymdtnv/C5/ALO7+fagI+xBZPcJ
	kKpMLEFAsSGs4x8K2sd2F2KlID8QZjDfoKyevupY9w2lLW37X52plgJsRtjjlM+djr8wpvSUQto
	JSbrSFyYrgWteHE9wV8cWqHUrH06RHb0Xh+bXPqeXChlZYLGGFkcBIPvSPH3jIYPHaRGwlpxBR8
	PedfQ+HBU8PKXymwonaKQTit60i8oOsVzAQECsTgHDnEBsox8/X8FDsBJCLQ==
X-Received: by 2002:a05:6a00:4187:b0:853:2e35:ad84 with SMTP id d2e1a72fcca58-8562a4e89aemr63794080b3a.14.1788288371275;
        Tue, 01 Sep 2026 11:46:11 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-85db24f33a0sm300383b3a.9.2026.09.01.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 11:46:10 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
 <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Scaria
 Kochidanadu <s-kochidanadu@ti.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] cpuidle: psci: Assign domain callbacks to all CPU idle
 states
In-Reply-To: <CAPx+jO85NBZq=YCxhs5Fbo5rDZ7pGHHKiG2HRJUNVKj_1SOscg@mail.gmail.com>
References: <20260831-topic-lpm-psci-domain-callbacks-v1-1-4a47d95c9c79@baylibre.com>
 <CAPx+jO85NBZq=YCxhs5Fbo5rDZ7pGHHKiG2HRJUNVKj_1SOscg@mail.gmail.com>
Date: Tue, 01 Sep 2026 11:46:10 -0700
Message-ID: <7hh5k87qtp.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ulf Hansson <ulf.hansson@oss.qualcomm.com> writes:

> On Mon, Aug 31, 2026 at 8:52=E2=80=AFPM Kevin Hilman (TI) <khilman@baylib=
re.com> wrote:
>>
>> Previously, only the deepest CPU idle state had its enter and
>> enter_s2idle callbacks set to the domain-aware implementations. This
>> meant that if a QoS latency constraint excluded the deepest state during
>> s2idle, find_deepest_state() would find no state with enter_s2idle set
>> and skip the domain idle path entirely. Similarly, during normal runtime
>> idle, shallower CPU idle states could not trigger cluster-level domain
>> idle states.
>>
>> Assign both enter_s2idle and enter (non-PREEMPT_RT) to all non-WFI CPU
>> idle states so that the domain-idle-state logic is triggered regardless
>> of which CPU idle state is selected. The genpd governor remains
>> responsible for honouring domain-level latency constraints independently.
>>
>> The enter_s2idle path uses dev_pm_genpd_suspend() which is safe on
>> PREEMPT_RT. The enter path uses pm_runtime_put_sync_suspend() which may
>> sleep and is therefore still excluded on PREEMPT_RT.
>>
>> Suggested-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>>  drivers/cpuidle/cpuidle-psci.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-ps=
ci.c
>> index dcf20ea5ef5e..db9aa57c51f5 100644
>> --- a/drivers/cpuidle/cpuidle-psci.c
>> +++ b/drivers/cpuidle/cpuidle-psci.c
>> @@ -250,6 +250,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_=
driver *drv,
>>                                      struct psci_cpuidle_data *data,
>>                                      unsigned int state_count, int cpu)
>>  {
>> +       int i;
>> +
>>         /* Currently limit the hierarchical topology to be used in OSI m=
ode. */
>>         if (!psci_has_osi_support())
>>                 return 0;
>> @@ -261,14 +263,22 @@ static int psci_dt_cpu_init_topology(struct cpuidl=
e_driver *drv,
>>         psci_cpuidle_use_syscore =3D true;
>>
>>         /*
>> -        * Using the deepest state for the CPU to trigger a potential se=
lection
>> -        * of a shared state for the domain, assumes the domain states a=
re all
>> -        * deeper states. On PREEMPT_RT the hierarchical topology is lim=
ited to
>> -        * s2ram and s2idle.
>> +        * Assign the domain-aware callbacks to all CPU idle states so t=
hat the
>> +        * domain-idle-state logic is triggered regardless of which CPU =
idle
>> +        * state is selected.
>> +        *
>> +        * For s2idle, enter_s2idle uses dev_pm_genpd_suspend() which is=
 safe
>> +        * on PREEMPT_RT. find_deepest_state() will pick the deepest sta=
te
>> +        * whose exit latency fits within the active QoS constraint.
>> +        *
>> +        * For the normal idle path, enter uses pm_runtime_put_sync_susp=
end()
>> +        * which may sleep and is therefore not used on PREEMPT_RT.
>>          */
>> -       drv->states[state_count - 1].enter_s2idle =3D psci_enter_s2idle_=
domain_idle_state;
>> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>> -               drv->states[state_count - 1].enter =3D psci_enter_domain=
_idle_state;
>> +       for (i =3D 1; i < state_count; i++) {
>> +               drv->states[i].enter_s2idle =3D psci_enter_s2idle_domain=
_idle_state;
>> +               if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>> +                       drv->states[i].enter =3D psci_enter_domain_idle_=
state;
>> +       }
>
> This breaks the current contract for genpd when it tries to select a
> domain idle state for a group of CPUs that shares the same PM domain.

Could you elaborate on what that "current contract" is or point me to
where it's described in more detail.  I understand there was a reason
for this design choice when first implemented, but now that we have
added support for using QoS to constrain the state selection used for
system-wide suspend (including s2idle) this "contract" is really
restrictive, and doesn't allow the domain idle logic to be used at all
for shallower states.

> In principle, if the CPU has a clock gating state (shallow) and a
> power collapse state (deep), it would be sufficient for the CPU to be
> in the clock gating state, while allowing the cluster PM domain
> (through genpd) to enter a domain idle state that corresponds to a
> power collapse state. Depending on the platform of course.

Yes, that is possible in principle, but with an important clarification:

Once all CPUs are in an idle state (either shallow or deep), the domain
idle state logic is entered.  It's then up to the domain (or its
governor) to select the appropriate state(s) for the domain.  If any of
the CPUs are in a shallow state, the domain governor should not allow a
deep state.

In your example, you mention the CPUs in a shallow state but the cluster
domain would pick a deep state.  I would say that's a bug in the
PM domain (or its governor) if it would allow that.

The job of the PM domain is to pick the deepest state that is possible
based on the state of the devices (including CPUs) that are in that
domain.

The same is true today for domains that do not have CPUs.  If you have a
device that runtime suspended, but in a shallow state (e.g. only clock
gated), the PM domain it is in should not hit a deep (power-off) state,
otherwise that device will lose context and not resume properly.

I'm trying to enable that same thing for PM domains with CPUs.

> On the platform you are working, is there a clock gating state (or
> similar) on the cluster PM domain, which is allowed to be entered when
> the corresponding CPUs are in the similar state?

Yes.  Not only the CPUs have shallow and deep states, but the domains
can have shallow and deep states as well.

Kevin

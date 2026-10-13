Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AF22579E
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859634; cv=none; b=j6GF/lgi2mrzDRN8OkvNG5pb1oib72HaklZkI60r2mAK/dqZQpwFbvUuNs13XzgwbXZZFRVAJJ7F3gdMQ6ElYs8che6s/Y8/VYiaFHA614QYssmSIZZpm+bAJJOILNZM1c7/tUlclBiyi/ZkHNq9l52zjJ4FOJZggtxt9jlMNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859634; c=relaxed/simple;
	bh=e5qJ7/cHRftpI/ExivZm6EQbTQ/U1hWJ1r+cnnvzTAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2Igd8AaBlcA6T5nOMdKqQdvQg3dchlS5w8tsWoZFUs+WHRfU8AeCX4ATE6k0w299XRObCfu21Ta+mC6VIYmyzKT6DUjKxJOxBaikiQ2uddBtyYEj3+IAbkQngAEVSfFwJD0iCSQy3r6g0iokNCjx4UbwmlKD9NvxUhGBSNhdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY/GIQoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY/GIQoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374C11F000FF
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 02:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791859632;
	bh=Py5W+zOf8jcv9SphAVIYRIsYaiROXNPiORfkJ1reQcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UY/GIQoVqGInseWJ0P177oKkczg7WZqyGiTPQd15EKdjXUbz9Aj1Jex+dVj3hJgX+
	 zciF2wxTEVW2oxSfvWvBO9tw9llIS6BetYsqVw4c+0J5JHli5fHajP6eoaVUUiiQh8
	 IYjCtHxjTBtDu5IJ/6AzNf7WAtK4WBaDQptg/xrmR7c2j6/CUyhJi8CfF2b+/OqzeF
	 fpxNyonQY3jchjNL26IaR8nhOxEiutpLZxyZGDjsUdhGonPKG3OLNixgXILOASsAgh
	 up4QgyFLSap5+eHjDfyr8K8LDmCLXGvmsYWLN43DaJtzXFCICHpCxpP/13iT6aMTCx
	 xiecxPubDIA4g==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so2619008a12.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 19:47:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByFD+3LPAuWAT6iVm+DTlFsGlERWXwqeYKZh91E4aBTla8yJJx9vfw6oBx/9LdniuT/0UliM7qpxIA6cXxW+w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIe/R6RQO1q21yPEbhKJRy79bpl74UMR49cOY5DhDEFgwFr/hOI
	scS6mbEy+l61Uo75A8YZt6t/dz4uDO+ZBVJq4wTk8VCQsPAXGyUtx10QSPzmE6D0cYLGEyewX9Y
	IzHlVZwmlKdWwQQkqO6wKOEiI6hJOgCs=
X-Received: by 2002:a05:6402:1d49:b0:6b1:c327:a9d0 with SMTP id
 4fb4d7f45d1cf-6b1c327b8acmr3296104a12.40.1791859630439; Mon, 12 Oct 2026
 19:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261012090431.TF3iVDsk@linutronix.de> <CAAhV-H4=nnhbJS4srmt7dNdgpkEZ8_RQ5Z+0baYMiXF1UrJ3KA@mail.gmail.com>
 <20261012102143.lpVrHb9R@linutronix.de>
In-Reply-To: <20261012102143.lpVrHb9R@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 13 Oct 2026 10:46:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7xME-UrgMHcfY41793yxWyvgEMAufwgcboEL2q3Jg+VA@mail.gmail.com>
X-Gm-Features: AclHuK-5nGNIjnalns2TTYeuiR7MEop7yTmsqLsf4e42_RR9QXEQZeMe2PdFpnw
Message-ID: <CAAhV-H7xME-UrgMHcfY41793yxWyvgEMAufwgcboEL2q3Jg+VA@mail.gmail.com>
Subject: Re: [PATCH v4] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP notification
 to task_work()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>, 
	Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
	WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Clark Williams <clrkwllms@kernel.org>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, James Clark <james.clark@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:21=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-10-12 18:15:51 [+0800], Huacai Chen wrote:
> > Hi, Sebastian,
> Hi Huacai,
>
> > > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpo=
int.h
> > > index db199d653dd1a..91e8d80220c54 100644
> > > --- a/include/linux/hw_breakpoint.h
> > > +++ b/include/linux/hw_breakpoint.h
> > > @@ -85,6 +85,9 @@ extern int register_perf_hw_breakpoint(struct perf_=
event *bp);
> > >  extern void unregister_hw_breakpoint(struct perf_event *bp);
> > >  extern void unregister_wide_hw_breakpoint(struct perf_event * __perc=
pu *cpu_events);
> > >  extern bool hw_breakpoint_is_used(void);
> > > +extern void perf_arch_hwbp_send_sig(struct perf_event *bp);
> > > +extern void perf_hwbp_notify(struct perf_event *bp, struct perf_samp=
le_data *data,
> > > +                            struct pt_regs *regs);
> > Maybe this declaration can be put in one line because there is no 80
> > characters limit now.
>
> We don't save much, do we? It looks more readable. Maybe if the perf
> maintainer requests it. Looks like waste to repost it just for that.
>
> Any comments on the looong bits?
Others look good to me.
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

>
> > Huacai
>
> Sebastian

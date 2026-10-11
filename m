Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E7429CC6
	for <linux-rt-devel@lists.linux.dev>; Sun, 11 Oct 2026 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791710150; cv=none; b=L65ahxDu/dtKRe5g0HDq3YjKCY0wL9Og/lLpWCw8IGE40BbjA4j4CFFDzaLN6wMBZt8n4I3VaauWPXdEIYsjsp6GtR+1ll51SAh4QYIDHI6e1nKsxO4mLseDcW1RpsAo1+3w5nzYlSi3FnwtlxDdE2/9oCGESale5ghNREOmbQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791710150; c=relaxed/simple;
	bh=7Gl7Ayp74qaimOMxS1INFdTCqa1RAX7txx60K/cfIRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DtrS9jvcitXpfubKplQWBJR1FofBODYTKY4uI2wsAtf8jrReggbH4hoYizSlOFFensBG5e3R8yq4St04twdfvQEZdwQAymBMzV13OZwOCgG3ezHcB1uoCgUGKx1l9EpEYFYWSZBHW7Hjvzb1kN4rw+FlemNdr3zvSkpX3Ltw2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aVpC2zqV; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aVpC2zqV"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j2ZhJ3T89zKp1y;
	Sun, 11 Oct 2026 11:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791710144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fXsRlSFHujyzLEoilfkijR8moHreeMnS9TPuWc9y9w=;
	b=aVpC2zqVdgts6ZZqD69iKdqgBO46oWBZ5TkbDHoOkDyhkx5lH5ybcgH7sHl25XHVLhzBfX
	wpOaXR74XqvdxehtAzm+w83jQKCbWDmhUdbUHpxReBxh0ShcbqmhSVZfnz/zP70FOp2fUY
	7xKuCd/c8FVD9qh2qQpb2XZ4W6pYFgiq3wYe6wVqz+h9A4VW7QzqXF7fDUoFt0syPNJE0z
	cJRFUvgiUyneAOakIr1+9CKgC5Wg+88wZRHIW38DdKYnISRnpfGNWpHnftyXJXVnxM1zaF
	2v5TmIPabztbKYbvHaBCmzXhGLjskIItvBNn+MrL0dPW5+HuJfSTU8WOgLJw9g==
Message-ID: <e1f99f25ebd6153bca81b36646869a080bf19b35.camel@mailbox.org>
Subject: Re: [PATCH v6] softirq: Preserve interrupt context during IRQ exit
From: Manuel Ebner <manuelebner@mailbox.org>
To: Karl Mehltretter <kmehltretter@gmail.com>, Peter Zijlstra
	 <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Frederic Weisbecker	
 <frederic@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt	 <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>, Lyude Paul	
 <lyude@redhat.com>, Joel Fernandes <joelagnelf@nvidia.com>, Alexander
 Potapenko	 <glider@google.com>, Marco Elver <elver@google.com>, Jonathan
 Corbet	 <corbet@lwn.net>, Bradley Morgan <brads@mainlining.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>
Date: Sun, 11 Oct 2026 11:15:39 +0200
In-Reply-To: <20261011060742.30584-1-kmehltretter@gmail.com>
References: <20261011060742.30584-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-META: gtbu5881fs8uxn1pr85jgf4a6zah9e75
X-MBO-RS-ID: 619c9564fdef8a75e4b

Hi Karl,

there's no issue with your patch but I have a question. There is=20
'irqentry_enter()' instead of 'irq_entry_enter()' which would fit
better into the naming scheme. I guess the root cause is in
kernel/entry/common.c .

Is there a reason for the dropped '_' ? Else I would make a patch to unify
the naming scheme.

Thanks
 Manuel Ebner

On Sun, 2026-10-11 at 08:07 +0200, Karl Mehltretter wrote:
> __irq_exit_rcu() removes HARDIRQ_OFFSET from preempt_count() before
> the IRQ exit work. On the outermost IRQ exit, with no NMI or softirq
> state remaining, this makes context checks report task context. The
> softirq-dispatch, timer-wakeup and tick-exit checks account for the early
> decrement, but other code reached in this window sees the wrong context:
>=20
>  [...]
>=20
> diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/en=
try.rst
> index 79fdaed954d9..09942135aad1 100644
> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -197,8 +197,9 @@ return true, handles NOHZ tick state and interrupt ti=
me accounting. This
> =C2=A0means that up to the point where irq_enter_rcu() is invoked in_hard=
irq()
> =C2=A0returns false.
> =C2=A0
> -irq_exit_rcu() handles interrupt time accounting, undoes the preemption
> -count update and eventually handles soft interrupts and NOHZ tick state.
> +irq_exit_rcu() handles interrupt time accounting, handles soft interrupt=
s if
> +possible, handles the NOHZ tick state and finally undoes the preemption =
count
> +update.
> =C2=A0
> =C2=A0In theory, the preemption count could be updated in irqentry_enter(=
). In

Here in entry.rst

> =C2=A0practice, deferring this update to irq_enter_rcu() allows the preem=
ption-count
> =C2=A0
> =C2=A0[...]

Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E874766A7
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Aug 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149855; cv=none; b=IgfvPoqHvNOL3wPkmRE+a0ieBuCKouH7+jHuiCvZfRqz+siS0Gt+7vlDmIIoNNf0L8jlknfwtlfcAmdvc4Rpjxa9ttq15B6drrEiq8Sf7Kxo4HSceFWe8ssug2OmjPfoIlXHHQBmu5mo3G5eSL8+zjlfZddFhuKRdsrKv7mTp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149855; c=relaxed/simple;
	bh=myNiNudWlAOhHqf78CNgDEMC2LXtqJxhUWb4ja/JZyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhZjy8t06T6t/hoPOp5bbtDvqbYJxlo3FMng+VPQrG6ViLKqknbjosqx8eoYju5pmetMUJs/l8WPW5bvdClvRU+hF57fiEvxrQfAppoO9ofkUrrmwnxvMAxbM80EKY0fwEXHQDkoy0NTo6Ku5i6sqiPMnfbyKY9ACUAew9sWxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Krf5ghZ9; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Krf5ghZ9"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260819143033bd61ee507c0002070f
        for <linux-rt-devel@lists.linux.dev>;
        Wed, 19 Aug 2026 16:30:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IoNmqk4kFe1ffi9HtpCtyUHKbQwKZ6Jed6SDch4oW9M=;
 b=Krf5ghZ9dUUHTj7Dh50SkIbWovR1VpLHU5vQyUfG0H0aqDOFeJuPJpqsNWdfvGzz2tM2Yb
 62YwWfAmla6In6QMb96eWCeNtft/RpDt5ZAVgR42w0BTzqoZ+ixyK3yqwory5ETNCaldAYx2
 iTLhrkdNalnGyE9Wnrivw+ZbDmeLWx31WRnizgD3okPjOsWKfdQC6ickBE/XPeNveHHip8SM
 amtBqX/abZgRXsuhA9ecQqlohTyravo6wYZ8yIl1MlEoK6ijfJY7FuGSKSjx6mx8WRXmcpSY
 U6GeoZZHyZaDDTa4bBxkfuLryIrdwLalGGVA6BgsuFUXLiZzwES/cOkQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 19 Aug 2026 16:30:31 +0200
Subject: [PATCH RFC 2/3] genirq: Honor existing IRQ affinities when setting
 affinity hints
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-2-3f79a99cadaf@siemens.com>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some device drivers implement an IRQ balancing / spreading mechanism
based on cpumask_local_spread() and irq_set_affinity_hint() (deprecated)
or irq_set_affinity_and_hint().

__irq_apply_affinity_hint() was overwriting already configured
affinities and with that violating user defined affinities.

This was especially a problem on systems with isolated CPUs, a common
pattern on PREEMPT_RT enabled systems. Device IRQs were balanced over
CPUs that were isolated for RT workloads.

Note that only the first call of irq_set_affinity_hint() and
irq_set_affinity_and_hint() - for each IRQ - will have any effect.
Afterward affinities might be controlled from userspace using the
/proc/irq/<n>/smp_affinity{_list} interface.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/irq/manage.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7eb07e3bdb4c2419e0a58a75c29d88b4b00b8287..3937ba24df6d63375dda88164cf92fd49e70a3eb 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -503,11 +503,21 @@ EXPORT_SYMBOL_GPL(irq_force_affinity);
 
 int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m, bool setaffinity)
 {
+	struct irq_data *irq_data;
 	int ret = -EINVAL;
 
 	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
 		scoped_irqdesc->affinity_hint = m;
+		irq_data = irq_desc_get_irq_data(scoped_irqdesc);
 		ret = 0;
+
+		/*
+		 * Do not overwrite the affinity in case an affinity for this
+		 * IRQ has already been requested, e.g. by writing to
+		 * /proc/irq/<n>/smp_affinity
+		 */
+		if (irqd_affinity_was_set(irq_data))
+			setaffinity = false;
 	}
 
 	if (!ret && m && setaffinity)

-- 
2.55.0


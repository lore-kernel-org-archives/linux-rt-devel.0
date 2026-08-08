Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A382D1F44;
	Sat,  8 Aug 2026 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786178690; cv=none; b=jqjVCoKrucQal/OgH5VyYycP/Y8psSMRR07RGsqaMdA+Sg8r1BG8Xasbgiq5j4n9lYd+j2jDgmJX2Tg1hRGvFP9U1MXvYZi/MG6Zl7g+T+Gky7B1bM6tfnAU9lLl9VOITYL3+i8xtlIt/RgyS+8Wp6lZVGjE+kX80dmnavYlBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786178690; c=relaxed/simple;
	bh=WtvfKxzuyQIxbslbU5OlYqvf/xsnlyieAnY+PYE5x8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHju9aWwUhcWTwv0wTlp2DOw7Xcb5rM2dNrztecIsN9feCAzkxpGc62E6D+ZqO4NTzfBlDy/Fv/zFBOYn0XT8dggzqnuzFUKl0Ya9os/vPsNSKaddapTKj3i42HYhxbEz7xt+7xEIl5DBt8qGYInDY4WRQhIFojpURWyXznY410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZDWLT1FG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZDWLT1FG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QeAUpskGyRCUNroI+oUG5WTw82pZX6a/avToWmOT4hk=; b=ZDWLT1FGRf+tesTah2b4D808yj
	qxYR4761L0bpo4qi+5ocgcNV7z/6RB/Zu0dMReAbyEohDDZWFo3OSGiWWtyiFBrNOz2/JQ5ffvoaJ
	x5klsOoSolv0paWWq+2F/+jDqIMJTVmOGahnoCS2CyC1KcL5MGcOTaLJo1T3H6G4RsBmDRu1Elueo
	Y/zIu1XeEtbVt3DYAafy318/jB/rHnf/F6UUhbig39eZ8WVl2jLkaLDkjzXA+R/IVMfx+mtOInfQ2
	MuvFWKcEYFjK05N3D7iocjVFwhK+uozZ/0VoTjzRUhqnBS2MnanOwGfyJll4TBOLH0d0onfdXe3Qi
	+Gf8heaw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wscfR-0000000Crgc-081O;
	Sat, 08 Aug 2026 08:44:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EA996300182; Sat, 08 Aug 2026 10:44:31 +0200 (CEST)
Date: Sat, 8 Aug 2026 10:44:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Bradley Morgan <include@grrlz.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] kcov: suppress timer and scheduler coverage leaks
Message-ID: <20260808084431.GS687043@noisy.programming.kicks-ass.net>
References: <20260807205027.31972-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807205027.31972-1-kmehltretter@gmail.com>

On Fri, Aug 07, 2026 at 10:50:22PM +0200, Karl Mehltretter wrote:

> Karl Mehltretter (5):
>   kcov: add kcov_pause()/kcov_resume() helpers
>   hrtimer: pause KCOV during deferred rearm
>   sched: pause KCOV in __schedule()
>   sched: pause KCOV in try_to_wake_up()
>   sched: pause KCOV in wake_up_new_task()
> 
>  include/linux/hrtimer_rearm.h | 18 ++++++++++++++++--
>  include/linux/kcov.h          | 25 ++++++++++++++++++++++++-
>  kernel/kcov.c                 |  2 +-
>  kernel/sched/core.c           | 15 ++++++++++++++-
>  4 files changed, 55 insertions(+), 5 deletions(-)

You've send me a partial series; which is the same as not sending me
anything at all. If you want me to look at it, send the complete thing,
so I can evaluate the whole thing.

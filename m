Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B914AD20
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 Aug 2025 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754324627; cv=none; b=osAI5WVGThHEguv0TTVG+JPD5Hy7jtaQJPC+NEnDdRq/KbqQgdZ/Wik5m0bb4gSV7KxSLz2bdEfzejz5mUXC77VUFPvFG0LVyB0+pkjZJ8wvLgRhGjuxE1FmlXVJjW2sW7T7bNNKy6ft3FZ9NgqPstCxhXesSqgKzQiFFk/UWKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754324627; c=relaxed/simple;
	bh=rk4xUEUB/wIq3rGpYo/X86zERgOioWig38qKf1KFMf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwxBMYm9dHl39UU1yoZPcNik6k6JERuRW6mzVKgKjBXwHvEEccRnLDwi766gysAk3d0uJAX0I3NsFOwQt7z5cRfEY0tpwALkB+XHrdPsR3yj46OMnBVddKYcv0fyp7fC39F4UkvxRSYpm+sWctLVrQG+deZ7SGt/IzuvRulSJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 0B4C5135D8E;
	Mon,  4 Aug 2025 16:23:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id ACB8660009;
	Mon,  4 Aug 2025 16:23:37 +0000 (UTC)
Date: Mon, 4 Aug 2025 12:24:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com, Yeoreum
 Yun <yeoreum.yun@arm.com>, ppbuk5246@gmail.com, linux-usb@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, syzkaller@googlegroups.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/4] kcov, usb: Fix invalid context sleep in softirq
 path on PREEMPT_RT
Message-ID: <20250804122405.3e9d83ed@gandalf.local.home>
In-Reply-To: <20250803072044.572733-2-ysk@kzalloc.com>
References: <20250803072044.572733-2-ysk@kzalloc.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: t4rc55o635fhjg6rz696cwy6myxzyf3y
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: ACB8660009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/5paMWW+Juq1mvbDF1JmMs9aEsrc8/mso=
X-HE-Tag: 1754324617-978494
X-HE-Meta: U2FsdGVkX1/z49nm5dzW8e07888n5rsRBE2V/oUx2Wl6piu/14hL6/w8DL10lbyE3UFHkmPyulIsjIUmaGozK8UEdkZDyOHw7gz8er+9MUQRQVu+iwbf5AOLYiYMR0+x1hKInbnzLa3L+u0CzxbvudUIH/Z405Z9xiVyMla0Tp75b1hiaalPT7NE9SyWPz9uz+MxC7mYxaXoscVV+pt1yUHQweUIcQcXLW1a5/CptZVbH2mqhCeqAFBfomtM5A1UUnb1xcTq6ssw0mL0MJYI6AYpZx/fuWEcAP8oraJpj0Y6c98jmomDvzvYE3MPWJwE4sl0y19HBizQ5cWMMQfiCMyKeQtpMPWv8vrTB5Lm8WKBjQSYd/ktIdR6ENGGhzHA

On Sun,  3 Aug 2025 07:20:41 +0000
Yunseong Kim <ysk@kzalloc.com> wrote:

> This patch series resolves a sleeping function called from invalid context
> bug that occurs when fuzzing USB with syzkaller on a PREEMPT_RT kernel.
> 
> The regression was introduced by the interaction of two separate patches:
> one that made kcov's internal locks sleep on PREEMPT_RT for better latency

Just so I fully understand this change. It is basically reverting the
"better latency" changes? That is, with KCOV anyone running with PREEMPT_RT
can expect non deterministic latency behavior?

This should be fully documented. I assume this will not be a problem as
kcov is more for debugging and should not be enabled in production.

-- Steve



Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB7225390
	for <linux-rt-devel@lists.linux.dev>; Tue, 26 Aug 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216573; cv=none; b=uZgf7AyYqdTpjxfnXxaDyR3WnuoKmJgk0AV88ABxdO4WWSoNVYCmbzq8YDWXmqHgKMMQ6M9HAfS5gOSSr+BIy5S6Ry+qMQb9pvlpZQKHCNWOl6QiERther1nqI3u4kZeo/bl733tysgoK4MB+PM9dem+5ftOesf2ky9+UpLAIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216573; c=relaxed/simple;
	bh=o0UuzVJewgDzlKHo7yZ+pvGPkU7yerKDou21wYPPAD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adfnjk8T3Ikhl72c5+g5J3h3igTxJgqKWs3GFoUF76hHqvBdGTuNAhLX7i5whbrwerArvd8TkF31YCCumYxi6F2DrUaHBD1MwBMaWV8vU3njgdvwuQ5Ax6q/O+Zbs05VxSsUDllg9ci7zDn4CWYrCvfAtrbUXiIos86WOgRZ+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D52731A011C;
	Tue, 26 Aug 2025 13:56:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id EA48920025;
	Tue, 26 Aug 2025 13:55:59 +0000 (UTC)
Date: Tue, 26 Aug 2025 09:56:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: cuiguoqi <cuiguoqi@kylinos.cn>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 guoqi0226@163.com, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched: Fix race in rt_mutex_pre_schedule by removing
 non-atomic fetch_and_set
Message-ID: <20250826095615.14259d90@gandalf.local.home>
In-Reply-To: <20250826110833.3274209-1-cuiguoqi@kylinos.cn>
References: <20250826110833.3274209-1-cuiguoqi@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: w4pinidjhh34uu1g5ofxywfautqk9kot
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: EA48920025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19u/wdqUBFa1SVm8m6A2koo1y9aRX3EoJ4=
X-HE-Tag: 1756216559-355501
X-HE-Meta: U2FsdGVkX18VH7mlupTCmtU4NsLFoZEpBFhDZfNbGRFx0pkbGyMOkMNdmGk0Rc345QynEBDkiQo4yxhRZRdr7ezSsDFTudtOg8SKJaTqMFw9MXoA3r11YwDmRWvZITF3WajT+Y+4zVODf9YbvHk1YtKnqhpdZGEUaTzx+8v0fA0apJlHjIiEm2u+8KytN8KaWNYgI2yc+RAvGkPfWH8Ladhqz161YVf6CaQnv3s5fFhTw2qGEnG6if+RxK4LD5oaewXfQzMcBm5GGEp4xll1+WFCWYcaLIw8/8uMlpYmYKRfspSwJTFN/C74V26/elSf

On Tue, 26 Aug 2025 19:08:33 +0800
cuiguoqi <cuiguoqi@kylinos.cn> wrote:

> @@ -7078,11 +7078,11 @@ const struct sched_class *__setscheduler_class(struct task_struct *p, int prio)
>   * name such that if someone were to implement this function we get to compare
>   * notes.
>   */
> -#define fetch_and_set(x, v) ({ int _x = (x); (x) = (v); _x; })
>  
>  void rt_mutex_pre_schedule(void)
>  {
> -	lockdep_assert(!fetch_and_set(current->sched_rt_mutex, 1));
> +	lockdep_assert(!current->sched_rt_mutex);
> +	current->sched_rt_mutex = 1;
>  	sched_submit_work(current);
>  }
>  
> @@ -7095,7 +7095,9 @@ void rt_mutex_schedule(void)
>  void rt_mutex_post_schedule(void)
>  {
>  	sched_update_worker(current);
> -	lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
> +	lockdep_assert(current->sched_rt_mutex);
> +	current->sched_rt_mutex = 0;
> +
>  }

Honestly, without adding a READ_ONCE() or barrier() I don't see how your
change would prevent the compiler from making the code any different?

It may have "fixed" your issue because the compiler may have done things
differently, but this change doesn't guarantee anything.

Also, could you show an example of how current->sched_rt_mutex could be
corrupted?

-- Steve

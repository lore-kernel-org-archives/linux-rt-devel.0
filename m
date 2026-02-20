Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B632E72F
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602257; cv=none; b=TQXh6BwKABkweTX1yIMndh2j/qHBSvQmSGrP4n/PPmar3n8T7h8ZZ2aoYrUi1Wlp6bkxZcxnPZejXXAJjYIw2JhWp+4eWdLbH4gc83vwJ0Nv7kT/o4Kyx21+TuruJ7yv4kdf1hR4NRhk6k4A5u7yLSNFCNgWhDxHbpvxAAqudv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602257; c=relaxed/simple;
	bh=fDZJFktL+aZlF4wlg3ZHXqvmIWUnd8oFFQaJdaPFCT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKt+S1ScUTnrXEdWBbvuUbXe1q2yx4+M+K1rIWPsW4dcZkkuJWk+VOayQE39XGCB7rEP6/XR8bULD9KpVjm05z81O8p9HJYQ745HoITtCp+N5R7/ZRVKxDZfJYWq4hHUVnVE2QSzGG0cqj5FbnquMZ+jC52iMjZ6rg6L4YNgwvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id EB00F140201;
	Fri, 20 Feb 2026 15:44:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id C68E420010;
	Fri, 20 Feb 2026 15:44:11 +0000 (UTC)
Date: Fri, 20 Feb 2026 10:44:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Calvin Owens <calvin@wbinvd.org>, Tejun Heo <tj@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, dschatzberg@meta.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: ~90s shutdown delay with v6.19 and PREEMPT_RT
Message-ID: <20260220104420.54610b04@gandalf.local.home>
In-Reply-To: <1d56c93ee93334b9d320c93d255d7548f4497836.camel@web.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
	<20260219164648.3014-1-spasswolf@web.de>
	<aZd4YCNTAHZNpTfh@mozart.vkv.me>
	<594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
	<20260219195851.7a7bd1b2@fedora>
	<1d56c93ee93334b9d320c93d255d7548f4497836.camel@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: injbsey6k9z4sq79k6u7zad58mktkokq
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: C68E420010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18k6Fx9aX9zpUOhhkDJBqPj3khvJkruyOk=
X-HE-Tag: 1771602251-398417
X-HE-Meta: U2FsdGVkX19gNafcIhT7kMlpHQj0pa40bGsA0s3CEReVolfQNNxR0Q73Okp5Q8/8Y/pM67zH/LGqTVPI6/SbJmcmz8WMckxiixn2/TVyYS22LgUFMqMkY+C6XOrPe1ZKlOTndAF8KTVRFqkZwVaU8U4xQ9JRjFir7q4jc/R1fSKvAWvKG443+o8XwKjKUOc1QpAqj/VGCjXkDVK6u9F9nKjcn//G2ttoPtt6RjrkTsNit4V/rzqAJlS/JVQESUsztykGuG8EEw7+0Mm8cYNMK0EdBMy7o2gB9rypTvVNZQ/RXjDfbOq30/am1O5bxdB/te0ZURnMZ9MObd57ooCZh00em7Am7kutviqWRpCspp4QQGiIiIpwTA==

On Fri, 20 Feb 2026 10:15:43 +0100
Bert Karwatzki <spasswolf@web.de> wrote:

> > It will enable sched_switch event and the traceoff_after_boot will
> > disable tracing right before running init. That way you can see what is
> > running during boot that is taking the 90 seconds.
> > 
> > -- Steve  
> 
> I think there's a misunderstanding here, the 90s delay happens on shutdown, i.e.
> when using either reboot or shutdown. I've changed the subject accordingly.

In that case you should be using the persistent ring buffer ;-)

  https://docs.kernel.org/trace/debugging.html

Add to the kernel command line:

  reserve_mem=20M:2M:trace trace_instance=boot_map@trace

And then before rebooting:

  echo 1 > /sys/kernel/tracing/instances/boot_map/events/sched/sched_switch/enable
  echo 1 > /sys/kernel/tracing/instances/boot_map/tracing_on

Then look at the trace after the reboot:

  cat /sys/kernel/tracing/instances/boot_map/trace

If your laptop doesn't clear memory during a reboot, you should have the trace.

If that's not enough to debug the situation, you can enable other events,
or enable function or function graph tracing. That should all work with the
persistent buffer.

-- Steve

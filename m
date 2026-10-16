Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545B04FD782
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167490; cv=none; b=JZ6iJtfhy3VP8xVA7EYHbzhI7ALJFIxS+5SsVOkxRAjeHeWDuHnTA9ICWNDGucuuwFMEUH1KMsM7d5x9WkZDElRxObKJoBxqRcexoiMOE/Xqsew/xowXOOclhSHpzom5NtxCg/X/iJ7KI3fnHNpbm3UHNijEngngbJtMhG0jSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167490; c=relaxed/simple;
	bh=jYd0sOflROgQxbtJVaIS2VTwewDXVIgGs28S8z9cBe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jr0KQKdQrJ2ko58QFdLa/yMVKrzbicj1JLMXLYGYOWd6MxtGvgFWHUiUbZaOifGQ6KRkMvy/QR803Wg3kTSEhpU9GYzhK/Z4DOi8dDZPL1w9oM1yM9LQhlOIFgcWopSHxVwZbOaj4Ae2CimGIFAFQ+t+RWb+FQ+HMdHD53epNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=5dDFdNVw; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="5dDFdNVw"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D3AE640564;
	Fri, 16 Oct 2026 16:17:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 3008B20012;
	Fri, 16 Oct 2026 16:17:55 +0000 (UTC)
Date: Fri, 16 Oct 2026 12:17:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <20261016121753.0da4e4e1@gandalf.local.home>
In-Reply-To: <7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
	<20261016112339.6d6ac80a@gandalf.local.home>
	<7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: kn54otfqrzdj5ae1ykzco435t3c6ycxs
X-Rspamd-Queue-Id: 3008B20012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+SBt2fk7D2ePaZ7XMzjE/xYxvmV6O7fu4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=baeEr3IW0PdScfTH8H/tjRu44VIzfeD0Gw3Qd+D31j0=; b=5dDFdNVwsLyR/0G4kgCn4tcjxQVjTZBz+VMCplnvok+0DB1Hoko6V8TjBTYPSPWlGSC2Ub2hlqqRZUbgCcKR0fWBgkkUU71EjfvlpuwBePIoojUodOlV3+dwp5c+gnGYrp0h4fFwfxX98BAqdeEZpArpgFyT8DapntbrJmZLO/k=
X-HE-Tag: 1792167475-795228
X-HE-Meta: U2FsdGVkX188a1ZMjpzUwIssenmtLJ2ChehF3yemqzkOPiXC9KXta5Ez9tffhrsambco4LMzzVNmTIFNRpdXkVF/G24uY1rtkpq6liWMkBEdh2UmwJiIfLghJ7z9rGTWuDwbstYg0/1+HAliILeqG1oyH1rBJ9Tc/DOTU7raEBulN3cD4RU8/b02JJiwTzugrEfGTzB6C89APm+u9kWgRNyzWDJRS6YeI3AGGKNrSs5yuSk2JKYjnUXRaRq3Mja1WekSmnV+Xq3BMS0oFpePv5K+Q+WKJcftmrQm5aU7z+a6F8qnq2a2ac0eX8bEm7eEhPqcMg8Kd80r85foEklWvPhn7K+mbD16

On Fri, 16 Oct 2026 09:00:31 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > > @@ -372,17 +381,24 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
> > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  	while (i) {
> > >  		t = ts[--i];
> > > -		if (task_call_func(t, check_slow_task, &rscr))
> > > +		if (task_call_func(t, check_slow_task, &rscr)) {
> > >  			pr_cont(" P%d", t->pid);
> > > -		else
> > > -			pr_cont(" P%d/%d:%c%c%c%c%c%c",
> > > +		} else {
> > > +			tc = rscr.rcu_rdr_cpu_task;  
> > 
> > Is there a possible race between the call to rcu_cpu_curr() and here, where
> > that task could have exited and is freed?
> > 
> > There's no get_task_struct() on that task.  
> 
> The get_task_struct() happens in the list_for_each_entry_continue()
> loop that it right before the raw_spin_unlock_irqrestore_rcu_node().
> 
> Or do I have an off-by-one bug here?
> 

But doesn't that loop just cover the tasks in &rnp->blkd_tasks?

Does that include the task returned by cpu_curr(cpu) ?

-- Steve

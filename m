Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5512AAF1
	for <linux-rt-devel@lists.linux.dev>; Sun, 18 Oct 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333280; cv=none; b=Qxxc1pu34E9nkcHTjAZpSZ97lqDpeIn5e9WrSBlAZXJPt6S5W3xMw4xj7i4o5qSNSppVoiKTGT1beKpIqJqcbeSthaAPuf1mIbWnJHRMwHRepxDCpkEcoQVXfCHh3rWVC24jrhK2AvCQOBqjB+dWtvBacgLBxvKuOrd0ISLLwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333280; c=relaxed/simple;
	bh=aq7D41iyHDz9VO6ZtNpkkv6k1+gtlytf5m9pie+8sno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4oBYehmOSeJMxoeXLIDUNa5CkszLY9tnlj72ntlJuH89/WUhywZLRzUr59lxdTZC56qDj7Xd/MKTB8W8rEFyVWfB/tn/jgy+M/CjpBScz9oWF4eobEUzDQxoIUidX3/3zTGSp6eS6c6PWzE3F02xnqaeb7v9wZ3DdCPZOj5dTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=hHcE/KaY; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="hHcE/KaY"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id C4FE3C0524;
	Sun, 18 Oct 2026 14:21:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 3CB892002E;
	Sun, 18 Oct 2026 14:21:09 +0000 (UTC)
Date: Sun, 18 Oct 2026 10:21:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <20261018102107.210318fa@fedora>
In-Reply-To: <fee69cc3-731d-4612-8b66-ecc9f16175ca@paulmck-laptop>
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
	<20261016112339.6d6ac80a@gandalf.local.home>
	<7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
	<20261016121753.0da4e4e1@gandalf.local.home>
	<d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
	<20261016125453.36ae8efe@gandalf.local.home>
	<112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
	<20261016134030.6791c1e4@gandalf.local.home>
	<4a1667ce-790a-4d85-ba2b-55f8729eea3f@paulmck-laptop>
	<fee69cc3-731d-4612-8b66-ecc9f16175ca@paulmck-laptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3CB892002E
X-Stat-Signature: yiczjwu5jgd1k4xyecpq1gdfeka9wemk
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19H1mPNgfVvj57S43wzgpOjjk1U3zz2fT4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=5SwTitGx++kdPo5ugj7cx3s/CXC/Pl6eA6iKRsbu7fc=; b=hHcE/KaYScCzD3TAINyk5WVLiVZlK5LyBjwLZaYTC4QUvddg9kY+SvHOLST2q/2+58U13Efpl8GtellBW963HN2BJKIz1gtToEQPsDGiekFQ534vs0w7sYhtwbkofFb9qaGREkgRDhz8qadGg2DW+bFyWPlDbY4I8LGyfWdh1O4=
X-HE-Tag: 1792333269-211463
X-HE-Meta: U2FsdGVkX18hNRsN1os8f1VYq8N0jyxKJ0RXO/HdsOg5Se42u+2WPoKIotZHmO98UwTuiT89uAqXEiGVdL7hN8nTYroidkIJmaMAkG67ySNRSeII1msQ8atZiguy/A/dIX9FbtbwLuqkvnaExEZZLI9eYIJXNUmQaG8IJpBFxUBndgHVn+IkFkfV9qiy50LKg5xe1qln3a4i/ZvPAoGyhRtyCMifTMbXw+LpihZoQO04iZ5FNE0YgJXMmqRy0jJ4LOdHzC7if+pD42AZZ07+GyOIrIEKjhdNX7ps8YYfz8QhM/DRkNpNCG9OfH6/RZ1ad/wsi5pXjuPhmpdL5KRLn/4YesllZeXB

On Sat, 17 Oct 2026 12:02:08 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > 
> > Or we can rely on interrupts being disabled across the full call to
> > rcu_print_task_stall().  This interrupts-disabled region acts as an RCU
> > read-side critical section, so that the call_rcu() in put_task_struct()
> > cannot invoke its callback (and thus cannot free the task_struct
> > structure) until some time after rcu_print_task_stall().
> > 
> > Does that work, or am I still missing something?  
> 
> Except that if this is the case, then I don't need get_task_struct()
> in the first place for any of them, do I?  I can instead just rely on
> the call_rcu() in put_task_struct() that had to have happened sometime
> after picking up the pointer to each task structure.

I was thinking that since this is called via a RCU stall, would RCU
still make progress? This is for task RCU right? But as you said, if
interrupts are disabled here, it becomes a RCU grace period itself. And
yeah, I don't think we need to call any get_task_struct() at all.

> 
> I clearly need to go through this one step by step and upgrade it as
> needed from a debugging hack to a proper patch.
> 
> > (And yes, even if it doesn't work, comments might be nice.)  
> 
> But this point still holds.  ;-)

Exactly. A nice big comment saying "we are creating a RCU grace period
here that would prevent put_task_struct() from freeing any tasks, so
any tasks we reference now will still exist when printing (as long as
we never re-enable interrupts)." Or something like that.

Cheers,

-- Steve

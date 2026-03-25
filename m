Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6F3EB7E3
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461300; cv=none; b=lIF7e1UVSup/mDZAD00zghNkYRATBGf2BDlipHNBgSfU7LS5DDgEdpjNd3aFIOXgSjLvsA8LiaDUQhJ61ILgYfnNxLSnDhYVlll4kO69PQN5MSRehW5fFBAEJbd3XkZDXzykFPlbreHSGxeoZV+CrdzuE4eMqsm4t7s7onTYPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461300; c=relaxed/simple;
	bh=f5pFZ2a2Xnwx1EdPsyp036XPOu4bBWmc3uSYKf0zl18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n776yOHu/L5quElV2LZBryubQAD95tHV6M1bAUOgE6JoVLhUz/XNYgH7SFr88Akh1dzF5nNR8DsfgKjDp2oWGDvNSYxRhsVxacf8odeVm6OnN/gfEk8vKZbgtQwkWyuBEYajzAgr99XLXQhkwCgqJVcM3asAxN5WKuUPmCide8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id A2E245B94E;
	Wed, 25 Mar 2026 17:54:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id A0A2D20012;
	Wed, 25 Mar 2026 17:54:55 +0000 (UTC)
Date: Wed, 25 Mar 2026 13:55:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org, "Paul
 E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260325135540.4d127635@gandalf.local.home>
In-Reply-To: <20260325175150._IrYQldq@linutronix.de>
References: <20260325030508.321405-1-jiayuan.chen@linux.dev>
	<20260325111351.1d38a0bc@gandalf.local.home>
	<20260325153826.EbSqlX_n@linutronix.de>
	<20260325115315.052e34ac@gandalf.local.home>
	<20260325155504.tm4zHWMI@linutronix.de>
	<5b6f6480-aa2d-4966-b3c7-6c719e915285@linux.dev>
	<20260325170539.MHkr49jU@linutronix.de>
	<20260325134433.7d46507d@gandalf.local.home>
	<20260325175150._IrYQldq@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A0A2D20012
X-Rspamd-Server: rspamout06
X-Stat-Signature: 3xqribss3nc4e65mitudhqwscbynupao
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18IaNsPSiZdPSiw/bPwbqbxMdboncrkBp4=
X-HE-Tag: 1774461295-227127
X-HE-Meta: U2FsdGVkX18JQhYjCe7nRQ4Iyn+1MXfd97Ct/Qs9jVOvPsFOQw0KCokxi0R192MiosBSCPV0xZJns0Omhcy8YuoXTj1datK/70FvLAXQFiyHlIK20JxYP4uPeb1v5VvTN28OaFzorS1+yoFee9USCfSWUQWg1QKskQatTO9lXZP291mNc4VPav9YlhvtEA1IBznPxK/q++GVa0Ud/UuE5xQ3chr5PcOz/eOzkMGbi5m93y4oCPHGvZbPsL6S31IvbD7fGZ3vdKR6c4mRlXRz7fdayJ8IeCn3OTaQN5Xv/75wLJy2x59NKFfMYOwPNjeJ

On Wed, 25 Mar 2026 18:51:50 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > Perhaps Jiayuan's idea is better as it will not require modifying current
> > callers and does fix the issue.  
> 
> Don't you need to replace irq_work_sync() with this new one?
> 
> > But it would still need helper functions from RCU as I really do not think
> > it's a good idea to open code the rcuwait logic.  
> 
> Why is rcuwait a concern?

Oh, I was talking about how the patch open coded rcuwait (which we shouldn't do).

Are you saying that if we stick a synchronize_rcu() in irq_work_sync() that
could work too?

-- Steve

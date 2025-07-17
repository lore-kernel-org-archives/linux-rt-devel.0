Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B51F4623
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Jul 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769174; cv=none; b=V1sZepfpHkTfoCdus4DB1YV4Ir/WfQHDiJnJwgGOdOOSXnB90tU5mhlVTw4Fz0qz9d7ZmnhOZDdsFNWGPCp9M+rTmCi3dc50L+sjJvjwYsezKQY5pI2bMHda1lSvvSMtcn7ky3k9fD3wzjj65pxm/EYxtA8m41RmBc5W/iUQOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769174; c=relaxed/simple;
	bh=zyVsdAl8M2hwLLcgWjwH2lrEtkq4tLivn3VgWIRNc9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNRO9DobJvgMokTSA1iTdpfOsCA8k1k8NZQazJl1ETKv98dkpHI6LW/z+rt94L4j8oiWr5V6ghzHOCZurKM7tYk676GnQrh/mEgaGExV9fvwxdl2KTRhz4JlTkFPUph8uE/FbbWmeD4da/ao6JcvA0pbS6JYYWAZhy8XDdHFmGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 824CB140154;
	Thu, 17 Jul 2025 16:19:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id B870120026;
	Thu, 17 Jul 2025 16:19:25 +0000 (UTC)
Date: Thu, 17 Jul 2025 12:19:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <20250717121924.7d5549f2@batman.local.home>
In-Reply-To: <CAADnVQJwpM=DfWjYe12pbx=Yb9NR5MRktzwgV_ALjLqMR3w9nw@mail.gmail.com>
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
	<29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
	<acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
	<ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
	<512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
	<bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
	<16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
	<20250716110922.0dadc4ec@batman.local.home>
	<895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
	<bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
	<e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
	<CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
	<20250717111216.4949063d@batman.local.home>
	<CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
	<20250717114028.77ea7745@batman.local.home>
	<20250717115510.7717f839@batman.local.home>
	<CAADnVQJwpM=DfWjYe12pbx=Yb9NR5MRktzwgV_ALjLqMR3w9nw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B870120026
X-Stat-Signature: yqpei3kibyawnrqz9rzebzuosh1yqi4i
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/FDy0cGsHdsURV7LUII6F6HBtwbHZrff8=
X-HE-Tag: 1752769165-600123
X-HE-Meta: U2FsdGVkX1/kX8EcLo5sJgKdKvVQvI4dVj/4WIlyiwvdW1It4tT2Yj5quiWHcSOJXxsfXAB9ht0IrPm3N4R7VyMzib2qHrQuQ9qsyROHaQjTqcU88qVoZpVHsVA1ibfIUyrnIChL0WoYpfQg59f+DrT+BGeDoKEcXxGnSwfdX41cxo+V/+dqGti6PEUm4P9Jx/em4tB7CIZMdMl6bXBOvr8vfcSC+SkjFhQD4RBbW30e7Cu0f4dmMLcWZBtEXa6NbE7lzpJjwEXwTMl37h+DU6iJhG0/VXiamEgkKTFsW3yeto9GabfI4TxYFHmquXaXGZHR3ESJyULxm+n8bjxKPs2gBuFFt14R

On Thu, 17 Jul 2025 09:02:38 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Stop blaming the users. Tracepoints disable preemption for now
> good reason and you keep shifting the blame.
> Fix tracepoint infra.

The fix *is* to have tracepoints not disable preemption. Your first
reply said:

   There is no need to replace existing preempt_disable wrappers
   with sleepable srcu_fast or anything else.

What is it? To replace the existing preemptable wrappers is the
solution. But you said it isn't needed.

Those using PREEMPT_RT look to blame the users that cause unbounded
latency. When you design an RT system, you look at what causes
unbounded latency and disable it.

Blaming the users is part of the process!

If BPF programs attached to tracepoints cannot be preempted, it means
it must not be used with PREEMPT_RT. FULL STOP!

It doesn't mean BPF programs can't be used. It just can't be used when
you care about bounded latency.

There's even people looking into configuring the kernel where if
anything gets called that can cause an unbounded latency, it would
trigger BUG(). As crashing the kernel in safety critical systems is
actually better than missing a deadline.

-- Steve

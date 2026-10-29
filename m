Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280937;
	b=cz95yV88UE0rJroLA9os804uwJ3KigUOXLRylpcztPpPcBcDogIWwgHDYEbYIh5Azhra
	 7Wa2ONRG9ON16iwWn92kTgzzWczITMQ6q+CwerwzpLWEWNkdYHiqQ1e7yHbAy6XCQ0dpZ
	 LDcOS+luZzDPl0bS9uLjQ8JF+6tRP9wWq9hW2UvMJpSsjFEUqjy1vdFUysttF7vY14buE
	 pKZEJBLcfkn3MiKijCn/Ec9FuAucFL55pHs7nVW2hXNnWNXFgxW59D8sZt4iGrxPwqaEJ
	 Svh3HqudYKCBZDzgFf2NFJ95f3ZBhVv3P4quVE/7zoIcRkcTx1dAGqJ/Tb/4GaK94Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280937;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=cpfF8iBPA4nr7a3PiDLkAoIOARyOru5ZKTKo03tTteg=;
	b=qnmsKxpIf4fcGNN2G5k+W/fQTiu6KuCpHGKNbJO20VK6NEijOhoNsIb36u7z1Zt29hrX
	 Nn0gLPsY/vJTTrixuNsTPTpwJLtJMA9D7Raa8t9HC7WWTJ7QtLrAYeN4d+lbUCNTSTIlM
	 D7Us9WIw5S9T0Gqv5HFE8V/1Mzvq84xc1gpMW42FNZy9KnZ7J57RcQpl0ShsM3lHWxCrc
	 0gYcQFcz2LPYqultclElE+7yyPaJO3ZZD9ZwjkaFz8USY669Dhz8y8oWqm1OUBEZ1bHSW
	 5sw4RutO7d74/DN7kjN8Yxg2gL/KLhbwdYoamURj6NceU4QBoS5FTIdCFOmJ9XXNsyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="Mk1gkUE/";
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70897606A31D
	for <linux-rt-devel@lists.linux.dev>; Thu, 29 Oct 2026 13:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70897606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Mk1gkUE/
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 95D15A03FD;
	Thu, 29 Oct 2026 13:35:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 61B7320016;
	Thu, 29 Oct 2026 13:35:31 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:35:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anvik Loitongbam <permissiontogallop@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Olivier Langlois <olivier@trillion01.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH] io_uring/napi: fix list use-after-free on PREEMPT_RT
Message-ID: <20261029093530.78de06dd@gandalf.local.home>
In-Reply-To: <20261029102244.141621-1-permissiontogallop@gmail.com>
References: <20261029102244.141621-1-permissiontogallop@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: z3o9sp9xj5pat4efzsx4pkcn6wc7amb8
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 61B7320016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+tgncKmmzR1u6rusjOetrrCY/NV7JPxUA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=cpfF8iBPA4nr7a3PiDLkAoIOARyOru5ZKTKo03tTteg=; b=Mk1gkUE/B7a0e7zTlK/5P25Vln+QhIjz3k7tKgwH96qdvgjCT+dqH+wSNxvcPiFKuiEkcHvK8sGNnTsBd1NWKznXeFobHnWk7kY+zgC5rtlMqrIWts1/V2LlvGzawsEJ5nhXHX4qJJhgutwCu1vFkKbuETk8MAhhC7dp2pkz1dU=
X-HE-Tag: 1793280931-685578
X-HE-Meta: U2FsdGVkX1/0LCuIv5h0CVc6QDc99JixsO5iV5r8bFdhvFOiaM+YSUt4xiguwAk/1yK0YY5JiTtSR2fnO9YhEITi7P48a9zmv4m3UavIJKv7TLcC4awwaSovBgcQn7w/+iBL4P6P6xKvcIxxi7Rc/I0laSkA5nXJozK/tSUM21EsIj/Qh1QXCE95XjmFUOEKLlouldTJFAgpjDv6MZv3uni2tuqC1laM/c34bEp5jZMIFwd8R+r4QPZvyduaEuI704Qmit9CBKZKX5gifeCwau3mt5Hfi/62gSAOmko9Xyj/ViU1GsCPM4SxkVpNx4eeRXEmwLYBAwTQOGzohSmIknpKjWs2KzfhQu0mFI8cRg4rLCu6iJt72IKmmCbu9k3CtC04Ig3yW17gWou3qwtK00+kXFCpieZp0BkgV51aNz4=

On Thu, 29 Oct 2026 15:52:44 +0530
Anvik Loitongbam <permissiontogallop@gmail.com> wrote:

> Commit 45b3941d09d1 ("io_uring/napi: fix io_napi_entry RCU accesses")
> converted the NAPI list teardown to list_for_each_entry() and
> kfree_rcu(), with a comment claiming that list_for_each_entry_safe()
> is not necessary because kfree_rcu() defers the free to the next
> quiescent state.

Not to mention, depending on the internals of list_del_rcu() and
kfree_rcu() is just not good design, regardless that it only breaks under
PREEMPT_RT.

> 
> This assumption only holds while the surrounding spinlock section is
> non-preemptible. On PREEMPT_RT, spinlock_t is an rtmutex and the task
> can be preempted while holding ctx->napi_lock. The raw lock inside
> kfree_rcu() only defers the preemption until it is released, and the
> release still happens before the iterator advances. Once the task is
> switched out, the context switch is an RCU quiescent state, if the
> preemption lasts long enough for the batch to be flushed and a grace
> period to complete, the callback frees the entry, and the iterator
> then reads e->list.next from freed memory. The same pattern exists
> in io_napi_free(). I did try to produce a uaf on an rt kernel
> build, but it did not work.
> 
> All list mutators are serialized by ctx->napi_lock, so the entry after
> the current one cannot be freed before its own iteration. Caching it
> first with list_for_each_entry_safe() in both loops might be a more
> safer and correct approach.
> 
> Fixes: 45b3941d09d1 ("io_uring/napi: fix io_napi_entry RCU accesses")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anvik Loitongbam <permissiontogallop@gmail.com>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> ---
>  io_uring/napi.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/io_uring/napi.c b/io_uring/napi.c
> index 7e698720cd51..d299c89cfc3d 100644
> --- a/io_uring/napi.c
> +++ b/io_uring/napi.c
> @@ -110,16 +110,10 @@ static int __io_napi_del_id(struct io_ring_ctx *ctx, unsigned int napi_id)
>  
>  static void __io_napi_remove_stale(struct io_ring_ctx *ctx)
>  {
> -	struct io_napi_entry *e;
> +	struct io_napi_entry *e, *next;
>  
>  	guard(spinlock)(&ctx->napi_lock);
> -	/*
> -	 * list_for_each_entry_safe() is not required as long as:
> -	 * 1. list_del_rcu() does not reset the deleted node next pointer
> -	 * 2. kfree_rcu() delays the memory freeing until the next quiescent
> -	 *    state
> -	 */
> -	list_for_each_entry(e, &ctx->napi_list, list) {
> +	list_for_each_entry_safe(e, next, &ctx->napi_list, list) {
>  		if (time_after(jiffies, READ_ONCE(e->timeout))) {
>  			list_del_rcu(&e->list);
>  			hash_del_rcu(&e->node);
> @@ -264,10 +258,10 @@ void io_napi_init(struct io_ring_ctx *ctx)
>   */
>  void io_napi_free(struct io_ring_ctx *ctx)
>  {
> -	struct io_napi_entry *e;
> +	struct io_napi_entry *e, *next;
>  
>  	guard(spinlock)(&ctx->napi_lock);
> -	list_for_each_entry(e, &ctx->napi_list, list) {
> +	list_for_each_entry_safe(e, next, &ctx->napi_list, list) {
>  		hash_del_rcu(&e->node);
>  		kfree_rcu(e, rcu);
>  	}


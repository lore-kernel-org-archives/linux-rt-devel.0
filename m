Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434626;
	b=EThHwNFeQIIRP/Nm16RpKalWNe2fWQE1RqNods0eshIQlBzA1Ngo/F0rqzQgU7TF8+VI
	 E1+UOBDsPKMOfZesrV+d10Xc4EoQ2BXTVOoQWntWER3E4bjoHl/YgOq0sJA5ZuhXTBZMq
	 cAYv/QT6rKDAnnYcUA1uyNpMGid0R4vwDysb5deEISXZ7ECa/N2jHTClPRkTQQWKBl+t7
	 tXTzSHQHwiJevW3Aw6aDYTR8CWMgbVPD0gH6XSP85Xt8o57abYCwvAoU64ME5ym120YZf
	 kSdkSVdpXiH+1JE9PEmix7019hE3a7+jyY/lfuQ6eGA1U+Sz6wjrNbOOGR6z2IO9TVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434626;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=JM2HF2CBW7kmOZAohZaF/zlwnzR8NPtgznofw2fGz2s=;
	b=ds5rMCTVuHD/colewggXitScgVPTMWMAmihmmWrcTRg5wqM2lfg2k82jlpCW0O9Pi+8W
	 SNK7p37Quo7FQpdO43JNVM/K6vgEt+jCm+Eik6eiDtk5h0WHWSl1rn0eBsNODmWOL4Z4/
	 X7ZUJqkgoFfN6gtcKP+5oWofchlI+1VLxwdd3itHxDmyQ6heGN5Q4YERR3BW8CguSEcon
	 xd81GHQTyzE7dbHiZBU44ZshbLRIShWBeWfONX50ZXK1g55VWgbvuvGnJUuJw8mqjEfcj
	 9TOKMXl2SbaF/ekQVFeYlgH4L3tu1ml9TmyQa9EWAsZKvXYYBErZI/MH82gDUE4gDqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=PzCkLZQd;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C4606A321
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 18:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B54C4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=PzCkLZQd
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 3FFE6A083C;
	Mon, 19 Oct 2026 18:30:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 9752A17;
	Mon, 19 Oct 2026 18:30:22 +0000 (UTC)
Date: Mon, 19 Oct 2026 14:30:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <20261019143021.42fbde3b@gandalf.local.home>
In-Reply-To: <846ce517-b063-4dc9-867a-603ff49bfd79@paulmck-laptop>
References: <20261016112339.6d6ac80a@gandalf.local.home>
	<7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
	<20261016121753.0da4e4e1@gandalf.local.home>
	<d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
	<20261016125453.36ae8efe@gandalf.local.home>
	<112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
	<20261016134030.6791c1e4@gandalf.local.home>
	<4a1667ce-790a-4d85-ba2b-55f8729eea3f@paulmck-laptop>
	<fee69cc3-731d-4612-8b66-ecc9f16175ca@paulmck-laptop>
	<20261018102107.210318fa@fedora>
	<846ce517-b063-4dc9-867a-603ff49bfd79@paulmck-laptop>
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
X-Stat-Signature: hss7ecxfsnrxj5owam8jgxxop87ipbyt
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 9752A17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+DcQ1o0Xtz8iefg7uKaovSLtsfQpW2QBs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=JM2HF2CBW7kmOZAohZaF/zlwnzR8NPtgznofw2fGz2s=; b=PzCkLZQdgz08Rs8hVsO1W6yWrThODiHKof39P6SCuCYkTZjcLS9PyjUNLwnFlGpmZm3gcVLPG94xt4QP6yxoJYRE0mPjTkrEo/QTWvk/G2rTEBjPv1PmSyDrOmxsk3iydQdgFw4jPT5cBqC2+8Ti6KLr2SQlnmnxhOjRaCN64zk=
X-HE-Tag: 1792434622-152960
X-HE-Meta: U2FsdGVkX1+v3c0anXMlogYRiIcCorNkRyb1sWV14/IdnPhrEekav23Lt91hdK4xkbTLjUOQ30+j3x/z7gUc52FmB7tbPHBm9mLV/xmf+lc1ojyBFFfdtdiQ1xc+JoObE4PMNVQZ/jVlnp0R8LBfK9Xh5GFXWI+WtbSiUdOOFX2jNPNQgkIy9TJTUJpj4Me4wNPcDbx7njdUqMHcfvWBvgaTaH6wrCaluFkOP0M4LmmwEQ03dOAFphz5VcJ/Z3SJtJMLFelwQGSYxFxFZH/k6aA7qlpH/HuHwMk4lRKRDGk31S/P7EjV53bKHNmusC0Yy6fzoVsq7ScE28hUuepSXkQpILcWG3JgO1mOyhp4pNAdCV8PIqI3N4vngjYpgUmLOlGCDDdda+em4axNSCAbkg==

On Mon, 19 Oct 2026 10:30:40 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 559735f71b5dd..1fa63eee528c2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11320,3 +11320,10 @@ void sched_change_end(struct sched_change_ctx *ctx)
>  		p->sched_class->prio_changed(rq, p, ctx->prio);
>  	}
>  }
> +
> +// Not for mainline, but hopefully someone has a trick that gets this
> +// job done.

Still not for mainline?

> +struct task_struct *cpu_curr_snapshot_rcu(int cpu)
> +{
> +	return rcu_dereference_all(cpu_curr(cpu));
> +}

Anyway, LGTM.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

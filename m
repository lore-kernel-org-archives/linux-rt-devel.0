Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438119;
	b=D9HltzAmHapdp8JtxRu65zZ3sf4hdzQpQUn/3CuCZr9u4qSXIyXpcSZKyPL31lr8pHc/
	 M+mvzuZPUmFAMqiAAIopv2e7QPTfIrBMNL71EFH3xc2XyHK3ymcPtTYTgdwhLcSIUvQYl
	 zGqudRvIbvDg04RhxOc66CrP/zLySFDlthfpcqG/sKxWs6a3MpoL5zC+ZFDR+qOU4h28O
	 CaR8rEWx57Wkk4eR/aSqk0EL1GHARhq9irheF75+/QEgTtWcn7rmYlpurAF4sJNtRzfNL
	 PYO/bV8bJWlCfiovulswUhwYa2UpbEyQxo41RO/ZAwzJsmDvocAy4/91PrwK0OYF2VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438119;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=cQg2c82yOgd3QDji2ofbE/1ZBmiKmK1gt0unNaBHe9c=;
	b=Pz8Yjv7uYB8ypmHNCW6Uukme6I0MQVWMb0ZVcKuGdTpjmdZuVaZNmRVRQm7oKOGUEy+t
	 +J8mNwX86Fpc4Og3Q31LvHiSgH9R1u7p/36xIltC60ByCT6yWRGEmoLufKkrbm06aTg0g
	 NfwBErQNaa9zI3nIcRihI5QTXPHacXgMHT1pip9w+17rNqDlBrh8gIzi1lm/temIJ1Psh
	 lNGimGLCg7LKrIi7GSgQ/zNiYwvdhfCvUJAnsCg9hGVh1Ypt73/yfd4i6tSQpUlUa0e6/
	 1h8RJcSZIgbWMsPmRljfHn4RLuX+I4g+jYJt6u3n25365K7ls2170DI+53Ha74OeCpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=js8rTUrZ;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50523606A31D
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50523606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=js8rTUrZ
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id DC199A06C6;
	Mon, 19 Oct 2026 19:28:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 3EDE930;
	Mon, 19 Oct 2026 19:28:35 +0000 (UTC)
Date: Mon, 19 Oct 2026 15:28:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <20261019152833.1ed30510@gandalf.local.home>
In-Reply-To: <41f07019-6412-415e-8f7e-5e5023ba31f6@paulmck-laptop>
References: <20261016121753.0da4e4e1@gandalf.local.home>
	<d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
	<20261016125453.36ae8efe@gandalf.local.home>
	<112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
	<20261016134030.6791c1e4@gandalf.local.home>
	<4a1667ce-790a-4d85-ba2b-55f8729eea3f@paulmck-laptop>
	<fee69cc3-731d-4612-8b66-ecc9f16175ca@paulmck-laptop>
	<20261018102107.210318fa@fedora>
	<846ce517-b063-4dc9-867a-603ff49bfd79@paulmck-laptop>
	<20261019143021.42fbde3b@gandalf.local.home>
	<41f07019-6412-415e-8f7e-5e5023ba31f6@paulmck-laptop>
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
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3EDE930
X-Stat-Signature: aowxsrikecum4pcip9mcgugnfteggb74
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18+wbgC9mukXr3cuCAkdhDs9zlhkoPDtpw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=cQg2c82yOgd3QDji2ofbE/1ZBmiKmK1gt0unNaBHe9c=; b=js8rTUrZJ5a5XEIwHCKfvMNh6pWQhvpQPjk5CgD7krGh/jNlmV5rJNojZteKuzubjxpO+F3DfC52tGpxP60S2HTJTy4vRNaW/EGnU10+mL2UGGHTszNS/whg8UdgQaQ0fBUCDjy6rd3v0sTpXi8j34KruuKMUG66OahunGzDpTA=
X-HE-Tag: 1792438115-331981
X-HE-Meta: U2FsdGVkX180Q08x6XMbFXPVoYH0tX7tU3Bp5Qw1sdNonTJchOgVsltPa0Pqpa2iJLS5v9o6GtHQD2HBVCaRuQ0l4TUXthe/8T5sV1HITIk07CiMzZqU3abnNWgage0kC+C1Jv8aqEVw9QcLsVoAyn+EmYQF+yzBR/CCx+CG/DOFE86CMFf8n/dXeqD3/OCQEpPFaFy7Ew71K2QZ85yixUZBY4NC/69bT+UgYh6sGMFUMWxILzm9/1azvCt0aOgLxwPwdIjgcuVbU1X2OH1SUhz/fTaQITPuafcvJHa0EzfBfNGW0Skucgfyv0rf2Z/kr4i0mkmsh+AxHUV/79Cj7MAK3UNd0qDz

On Mon, 19 Oct 2026 12:24:14 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> I have therefore updated the cpu_curr_snapshot_rcu() comment header as
> shown below.  ;-)
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> /**
>  * cpu_curr_snapshot_rcu - Return the task currently running on CPU *
>  @cpu: CPU to query * * The caller must either be within an RCU read-side
>  critical section * or must hold some lock that prevents the task from
>  exiting.  * * Return: Pointer to task_struct of task running on @cpu.	*/
> struct task_struct *cpu_curr_snapshot_rcu(int cpu) {
> 	return rcu_dereference_all(cpu_curr(cpu));
> }

Since this function has "rcu" in the name, perhaps just make it have to be
in a RCU critical section. Is there any time you will think this needs to
hold a some other lock for not allowing the task to disappear.

That is doesn't rcu_dereference_all() cause a splat if there's not some RCU
protection happening? I would limit this operation to just that then.

-- Steve
	

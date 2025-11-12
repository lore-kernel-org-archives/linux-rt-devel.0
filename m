Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30333385BE
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Nov 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962311; cv=none; b=DO4Km2/YnVSNIkBaPFysJl6+Ff6Oi+AIY2BA8+uXJkTE2X6PffFEvy0CI2q98+w9L7ZlVqY8CeDIPdnNiSa9/jg/DBDA1xDU+0IM0krqvXhXUdio/kJcqFwFli7g7UFtNmeSFZ0wcGr8FvhMAwV5Z6s1ANq0LPOoigqh5so1E9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962311; c=relaxed/simple;
	bh=K2NgcdDSsNIpmukvk9ZTuvgP7S9Fzwf2iF4Zv9Lx6wY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPrmZLDlFcVCWuIc4/g0vGjZQw/zRM6jYpwAFjxQQo8bXzLWbRSWthIJaEkfhREUBNYXokKhjfufOjdoP00Dr6iTF9Q++96jrkaWKY17KgIRWk9qKiWkfiCmPfoziOQr3YYLssl+E3wTKGmlg92UhKZLFCt6HCCYoKCE6Ab/28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id CDD17140573;
	Wed, 12 Nov 2025 15:45:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id C85DD32;
	Wed, 12 Nov 2025 15:44:55 +0000 (UTC)
Date: Wed, 12 Nov 2025 10:45:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo
 <harry.yoo@oracle.com>, Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Muchun Song
 <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Clark
 Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <20251112104508.5500ad9b@gandalf.local.home>
In-Reply-To: <jzihvbb6w26d4codfigy2o7b2h26izb4ahihouw54cvuzau54d@jyaa6rgpzuai>
References: <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
	<aQ3yLER4C4jY70BH@harry>
	<hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
	<aRFKY5VGEujVOqBc@hyeyoo>
	<2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
	<aRF7eYlBKmG3hEFF@hyeyoo>
	<aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
	<8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
	<aRKqm24Lrg-JnCoh@hyeyoo>
	<20251111084900.babaOj0w@linutronix.de>
	<jzihvbb6w26d4codfigy2o7b2h26izb4ahihouw54cvuzau54d@jyaa6rgpzuai>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8i46fu3i1uexab3gcai9n6jo5zxtnjew
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: C85DD32
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/zzJBKVnQjnF7+vD3iE7NPwFKeizQlGh4=
X-HE-Tag: 1762962295-724363
X-HE-Meta: U2FsdGVkX18sZXyIcTgAaFZzEaJim5B3AdsBNcnSuhkN2xVPR14V+jN/a1c5qbKBwiNNEDsYnm/64J4ywfekI1ESXBN6UJspS6OQJv2pFY4ePIxPhNzVl9Rm+8vU67m3SqAyq9LTVgOoNLhlzs0tmR4GFlK36oZ2M//1r6/uqVtRYmW841FrUMVYjYit8fHlXYKbBGeroJSS3BFYTvoXIMH5Z70gftOSU00Kt1bZvIjYFPdOyzv8A9vwq3mX3ifD5SZC3t2J5qSG6sJo6DrZkw5hpFnMuHHE12uSwei8c4W8RtEV9QEVyxIuOx7wSpSY

On Tue, 11 Nov 2025 08:44:14 -0800
Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Harry is talking about mod_node_page_state() on
> !CONFIG_HAVE_CMPXCHG_LOCAL which is disabling irqs.
> 
> void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
> 					long delta)
> {
> 	unsigned long flags;
> 
> 	local_irq_save(flags);
> 	__mod_node_page_state(pgdat, item, delta);
> 	local_irq_restore(flags);
> }
> 
> Is PREEMPT_RT fine with this?

But should be:

void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
					long delta)
{
	guard(irqsave)();
	__mod_node_page_state(pgdat, item, delta);
}

-- Steve

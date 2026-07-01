Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C13BADB2
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Jul 2026 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895914; cv=none; b=pE97wGMsY7r0jkeh0nZlSQUBBCllk0QCpoaRAfKea/uBaaKnMVyMq5SYDoVkr8uWxF5r0lfXngxI3+sazZ7AGQWeYVmML+TNT3Mf/gzBMyAH5vYUCBEz9Lyx9xGZnORwXrR5Ws5Cbg92HHeHT1pFcGClUHoMdDNBS5CMmH9smOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895914; c=relaxed/simple;
	bh=XYVsyvNcRAqRa7XXzRl33RSz0hLdYmvN57o202d5U9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NPEws7ufAvyzUMlxv9GuOWQ9fDMTW9nHIbby1Smu97ybxPmAJ9e5cI9Xchjliytsowi2fLRb9N85OUx1bwHAWYVDi0g84yh4eWvyheKHVYSO+AiNh/8BZ+sAn6cJXYl8LXuzSJEECFFnWqR4zRf3w9+MrluIVvpVMMC3vbz2ozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i/WxM8iZ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i/WxM8iZ"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782895910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WptujkoueVK4W82l5uzWeP4VkNxIbJRQVDPy957bR6Q=;
	b=i/WxM8iZ8GrjPdcPjCSi7qVYMN91pIv2LCUly1UdXPGZvcP95zU4rXHRHK5WnPPTSebNnc
	6qZBGxw0mYI7xo35etZQoa2mnGtUwk12wTdfnlcjHI3pv77RMq3IOl2zKGS4SRa3rEExMR
	FNnBiqLcyKqQYGm/Bg5c8q8Eb12BWE8=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 08:51:32 +0000
Message-Id: <DJN3UHUICJX4.3GN1396CO525O@linux.dev>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, "Robin Holt" <robinmholt@gmail.com>,
 "Steve Wahl" <steve.wahl@hpe.com>, "Arnd Bergmann" <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 11/16] sgi-xp: Use higher-level allocator API
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Brendan Jackman"
 <jackmanb@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, "Muchun
 Song" <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park"
 <byungchul@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Hao Li" <hao.li@linux.dev>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-11-57bef0eadbc2@google.com>
 <d7bee578-7f0d-48c3-9eb3-65999476b7f8@kernel.org>
In-Reply-To: <d7bee578-7f0d-48c3-9eb3-65999476b7f8@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed Jul 1, 2026 at 7:52 AM UTC, Vlastimil Babka (SUSE) wrote:
> On 6/29/26 15:12, Brendan Jackman wrote:
>> The difference between __alloc_pages_node() and alloc_pages_node() is
>> that the latter allows you to pass NUMA_NO_NODE.
>>=20
>> The former is going away and the latter works fine here so switch over.
>>=20
>> No functional change intended.
>>=20
>> Cc: Robin Holt <robinmholt@gmail.com>
>> Cc: Steve Wahl <steve.wahl@hpe.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Assisted-by: Gemini:unknown-model
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>
> Nit:
>
>> ---
>>  drivers/misc/sgi-xp/xpc_uv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
>> index 772c787268932..aacff70204241 100644
>> --- a/drivers/misc/sgi-xp/xpc_uv.c
>> +++ b/drivers/misc/sgi-xp/xpc_uv.c
>> @@ -170,7 +170,7 @@ xpc_create_gru_mq_uv(unsigned int mq_size, int cpu, =
char *irq_name,
>>  	mq->mmr_blade =3D uv_cpu_to_blade_id(cpu);
>> =20
>>  	nid =3D cpu_to_node(cpu);
>> -	page =3D __alloc_pages_node(nid,
>> +	page =3D alloc_pages_node(nid,
>>  				      GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
>>  				      pg_order);
>
> gfp flags can now fit on the line above?

Ack.


Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A939FCCC
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Jul 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897069; cv=none; b=Rt4Msq9j7Ote1PHvdd1uI8tvDjpCJDj78jGI/agDgfAOtmFOYC3ziWeFuZ7qKr3wcg9lhCK3QNs1GtKij4TI4PRkPjpydPOhfsPQnLN1h1KzvcU57k2KLjcPaDmw3rQ2Mp3kDsUGxihQ+TKeNuXVWLWgQ6tK3fIlheP9/QvT10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897069; c=relaxed/simple;
	bh=yRLxtG/kc8K/XUw2VuO3ZU+13HZ3XTj222MJKdjPSm0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=N1xwywAMmnKBBSQNoZX7SWZtcveUsS2l5PAHKBwrXmE6X0eyPBOk3A+j4q28y/A00sYHVZbv5SapwKpA2ueI4e4li81PU8+6PyffKEzJl8eaC77zyOIXT4ysOJgyHhnMq/nbeMGC2POxQe7cawmlWkEgbE7B36OE6jgb9UVRkhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=otUVHkUn; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="otUVHkUn"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782897063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRLxtG/kc8K/XUw2VuO3ZU+13HZ3XTj222MJKdjPSm0=;
	b=otUVHkUn2Guey0Wvyu2MA1B4h8xq2ByQDfQCYsdwAZjvKqm3ZUE4SIRI4A5DKjVE8oZTp3
	QnNLAOZIrM+lu8Mts/B6GKJc+M371Y9Gq06sdfyiXdCYAFgzTwbn2tW3BuPNSkT83QSRxq
	VVEiQsEgWeXrkAgpooWxsVQOjLwWv58=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 09:10:46 +0000
Message-Id: <DJN497WOOX18.12R5SMHHVM9N3@linux.dev>
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
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v3 16/16] mm: remove the __GFP_NO_OBJ_EXT flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-16-57bef0eadbc2@google.com>
 <e0ae6be7-4e45-4c4a-9663-a87fb260564a@kernel.org>
In-Reply-To: <e0ae6be7-4e45-4c4a-9663-a87fb260564a@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed Jul 1, 2026 at 8:32 AM UTC, Vlastimil Babka (SUSE) wrote:
> On 6/29/26 15:12, Brendan Jackman wrote:
>> All users of the flag are converted to SLAB_ALLOC_NO_RECURSE or
>> ALLOC_NO_CODETAG (from __GFP_NO_CODETAG which reused the NO_OBJ_EXT bit)=
.
>> Free up the flag bit.
>>=20
>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>
> For a correct process, there should be also a matching From:

Hm, that's weird. Maybe whatever weird idiocy I did that caused me to
not apply the whole patch, also caused me not to set the Author
correctly in Git? Anyway since then I've reapplied it and the From: is
showing up when I format it with `b4 send -o /tmp/presend` so hopefully
v4 will be correct...

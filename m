Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C151DE4E0;
	Sat, 20 Dec 2025 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766215441; cv=none; b=gRvWeCdYXM9O5w0/4DuLbmpDSLCMdjcMF/QhrWUjpmOkmoQLGcy9MtxNUsjSOETj3LvOTU77F1Dgkj1NrtaVKPFLmHJ/2SsJru9tQd8oByzRvNcjxJAzomP9DzBFSEcVaN48PXMByQX7+XUVXAtDCPfs0pU6K8Hq3cMXoNmBY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766215441; c=relaxed/simple;
	bh=HeVhro2dhwu32V4Eqnb8kNIV9QmwemotY9SDP9Bhafc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKpWtCCYsiZ0yqmPQDmfNsyeTFoVI6FpOqR+aLnm2tfOPyaV5dVO2EKCLlvkbT/3+S7J10wzp7IyUUIn8GAUJBLAR4x/t/3d84IKmjmVlELFCZAxBpz3MzqIcSmYNHvnak2Hw7EMmWkOAHXEBNZB0E3ZXqdPs77S0NHdj5fqTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhPC2Ke3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhPC2Ke3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F63C4CEF5;
	Sat, 20 Dec 2025 07:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766215440;
	bh=HeVhro2dhwu32V4Eqnb8kNIV9QmwemotY9SDP9Bhafc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhPC2Ke3KflCNf12hPQXvwkTWnWJP+UwYphS36IiagYhdO9i/csvJksZG00B0XTzY
	 /0pdQvELAjwOHS4DPvUziRA3G9sBKL02gGaRKx37Xj2vcRgQbIvJVvrSTT3deY1M+k
	 uRa7eRNbFEKCilRFFpY/ANeWZ3ltJrP9OKhyije4ZfebM6DQKUIkzaVXMxvZCrnFuL
	 lBQQsCJLHLT67AqhYSjKn7TDRNVGyzY0lqStPYXxaFk9+fldXVtBRLnZiexpfJOsRg
	 wGZccUZ4Ym1f3rMCGJlYuq7yZPMfbujcJ3hcJ82XX28KpclqhNXqX9OycooT0A7ADO
	 ClIfqAcCwQoUA==
Date: Sat, 20 Dec 2025 09:23:52 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] mm: clarify GFP_ATOMIC/GFP_NOWAIT doc-comment
Message-ID: <aUZPCFLIeAgdkioq@kernel.org>
References: <20251219-b4-gfp_atomic-comment-v2-1-4c4ce274c2b6@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-b4-gfp_atomic-comment-v2-1-4c4ce274c2b6@google.com>

On Fri, Dec 19, 2025 at 11:32:18AM +0000, Brendan Jackman wrote:
> The current description of contexts where it's invalid to make
> GFP_ATOMIC and GFP_NOWAIT calls is rather vague.
> 
> Replace this with a direct description of the actual contexts of concern
> and refer to the RT docs where this is explained more discursively.
> 
> While rejigging this prose, also move the documentation of GFP_NOWAIT to
> the GFP_NOWAIT section.
> 
> Link: https://lore.kernel.org/all/d912480a-5229-4efe-9336-b31acded30f5@suse.cz/
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> Changes in v2:
> - Specified section in docs reference
> - Link to v1: https://lore.kernel.org/all/DF0J58HOVLL4.2E16Q87D2UXRW@google.com/
> ---
>  include/linux/gfp_types.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.
